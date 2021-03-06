class RenewalService

	def self.send_renewals
		count = 0
		Renewal.all.each do |renewal|
			RenewalService.send_renewal renewal
		end
		count
	end

	def self.send_renewal renewal
		SmsService.notify_customer renewal
		RenewalMailer.policy_reminder(renewal).deliver
	end
end