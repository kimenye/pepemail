class RenewalMailer < ActionMailer::Base
  default from: "policies@aon.co.ke"

  def policy_reminder(renewal)  	
  	@renewal = renewal
  	attachments.inline['aon.png'] = File.read("#{Rails.root}/app/assets/images/aon.png")
  	attachments.inline['bg.png'] = File.read("#{Rails.root}/app/assets/images/bg.png")
  	attachments.inline['bg_2.png'] = File.read("#{Rails.root}/app/assets/images/bg_2.png")
  	mail(:to => @renewal.email_address, :subject => "#{@renewal.renewal_year} Motor Insurance Renewal - #{@renewal.expiry_date.to_s(:simple)}")
  end
end
