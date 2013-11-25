class RenewalMailer < ActionMailer::Base
  default from: "policies@aon.co.ke"

  def policy_reminder(renewal)  	
  	@renewal = renewal
  	attachments.inline['aon.png'] = File.read("#{Rails.root}/app/assets/images/aon.png")  	
  	attachments['policy.pdf'] = AttachmentService.generate_pdf(renewal).render
  	mail(:to => @renewal.email_address, :subject => "#{@renewal.renewal_year} Motor Insurance Renewal - #{@renewal.expiry_date.to_s(:simple)}")
  end
end
