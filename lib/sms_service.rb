#require 'RestClient'
require 'uri'
class SmsService
	def self.notify_customer renewal
		RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
		text = URI::encode("Dear #{renewal.first_name} #{renewal.last_name}. Your policy for #{renewal.registration_number} is due on #{renewal.renewal_date.to_s(:simple)}.")
		res = RestClient.get("#{ENV['SMS_GATEWAY']}&to=#{renewal.mobile_number}&text=#{text}")        
        Rails.logger.info res
		!res.match(/sent/).nil?
	end
end