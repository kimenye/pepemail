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

	def self.send_text number, message
		RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
		text = URI::encode(message)
		url = "http://197.248.2.82/receiver/21?from=INFO&coding=1&login=minetaon&pass=kjdg4782klj"
		res = RestClient.get("#{url}&to=#{number}&text=#{text}")
		Rails.logger.info "Request #{ENV['SMS_GATEWAY']}&to=+254#{number}&text=#{text}"
		Rails.logger.info res
		!res.match(/sent/).nil?
	end
end