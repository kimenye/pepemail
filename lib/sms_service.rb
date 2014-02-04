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
		RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
		raw_text = url.message
		raw_text = raw_text.gsub(/{{contact_name}}/, contact.name)
		url_hash = Digest::MD5.hexdigest("#{contact.phone_number}#{Time.now.to_s}")
		
		link = "#{ENV['BASE_URL']}track/#{url_hash}/show"

		auth = UrlShortener::Authorize.new ENV['BITLY_USERNAME'], ENV['BITLY_PASSWORD']
        client = UrlShortener::Client.new auth
        result = client.shorten(link)
        shortened_url = result.result['nodeKeyVal']['shortUrl']

		raw_text = raw_text.gsub(/{{url}}/, shortened_url)

		text = URI::encode(raw_text)

		visit = Visit.create! :contact_id => contact.id, :url_id => url.id, :counter => 0, :url_hash => url_hash
		
		salt = "YCZMLr2HC77f"
		unencrypted = "#{contact.phone_number}#{salt}"
		encrypted = Digest::MD5.hexdigest(unencrypted).to_s
		url = "#{ENV['SMS_GATEWAY']}&msisdn=#{contact.phone_number}&text=#{text}&pass=#{encrypted}"

		Rails.logger.info "Request #{url}"
		res = RestClient.get(url)
		
		Rails.logger.info res
		!res.match(/sent/).nil?
	end
end