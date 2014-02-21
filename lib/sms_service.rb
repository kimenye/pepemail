require 'uri'
class SmsService
	def self.notify_customer renewal
		RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
		text = URI::encode("Dear #{renewal.first_name} #{renewal.last_name}. Your policy for #{renewal.registration_number} is due on #{renewal.renewal_date.to_s(:simple)}. Your premium is #{renewal.amount_due}")
		res = RestClient.get("#{ENV['SMS_GATEWAY']}&to=#{renewal.mobile_number}&text=#{text}")
		Rails.logger.info "Request #{ENV['SMS_GATEWAY']}&to=+254#{renewal.mobile_number}&text=#{text}"
		Rails.logger.info res
		!res.match(/sent/).nil?
	end

	def self.send_link contact, url
		# RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
		raw_text = url.message
		raw_text = raw_text.gsub(/{{contact_name}}/, contact.name)
		url_hash = Digest::MD5.hexdigest("#{contact.phone_number}#{Time.now.to_s}")
		
		link = "#{ENV['BASE_URL']}track/#{url_hash}/show"

		puts "Link : #{link}"

		# binding.pry
		auth = UrlShortener::Authorize.new ENV['BITLY_USERNAME'], ENV['BITLY_PASSWORD']
        client = UrlShortener::Client.new auth
        result = client.shorten(link)
        shortened_url = result.result['nodeKeyVal']['shortUrl']

		raw_text = raw_text.gsub(/{{url}}/, shortened_url)

		# text = URI::encode(raw_text)

		visit = Visit.create! :contact_id => contact.id, :url_id => url.id, :counter => 0, :url_hash => url_hash, :receipt => false	
		self.send_international contact.phone_number, raw_text
	end

	private

	def self.send_international msisdn, message
		xml = self.create_message msisdn, message
		puts "Request #{xml}"
		options = {
			:body => xml,
			:headers => { "content-type" => "text/xml;charset=utf8" }
        }
        response = HTTParty.post(ENV['GATEWAY_URL'], options)
        puts "Response #{response}"
	end

	def self.create_message to, message
     xml = "<?xml version=\"1.0\"?>
      <methodCall>
        <methodName>EAPIGateway.SendSMS</methodName>
        <params>
          <param>
            <value>
              <struct>
                <member>
                  <name>Numbers</name>
                  <value>#{to}</value>
                </member>
                <member>
                  <name>SMSText</name>
                  <value>#{message}</value>
                </member>
                <member>
                  <name>Password</name>
                  <value>#{ENV['PASSWORD']}</value>
                </member>
                <member>
                  <name>Service</name>
                  <value>
                    <int>#{ENV['SERVICE_ID']}</int>
                  </value>
                </member>
                <member>
                  <name>Receipt</name>
                  <value>N</value>
                </member>
                <member>
                  <name>Channel</name>
                  <value>#{ENV['CHANNEL_ID']}</value>
                </member>
                <member>
                  <name>Priority</name>
                  <value>Urgent</value>
                </member>
                <member>
                  <name>MaxSegments</name>
                  <value>
                    <int>2</int>
                  </value>
                </member>
              </struct>
            </value>
          </param>
        </params>
      </methodCall>"
      xml
  end
end