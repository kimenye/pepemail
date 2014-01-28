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
		url_hash = Digest::MD5.hexdigest(contact.phone_number)
		link = "#{ENV['BASE_URL']}track/#{url_hash}/show"
		raw_text = raw_text.gsub(/{{url}}/, link)
		text = URI::encode(raw_text)

		visit = Visit.create! :contact_id => contact.id, :url_id => url.id, :counter => 0, :url_hash => url_hash

		res = RestClient.get("#{ENV['SMS_GATEWAY']}&to=#{contact.phone_number}&text=#{text}")
		Rails.logger.info "Request #{ENV['SMS_GATEWAY']}&to=+254#{contact.phone_number}&text=#{text}"
		Rails.logger.info res
		!res.match(/sent/).nil?
	end
end