class RenewalMailer < ActionMailer::Base
  default from: "policies@aon.co.ke"

  def policy_reminder(renewal, user)  	
  	@renewal = renewal
    @user = user
  	attachments.inline['aon.png'] = File.read("#{Rails.root}/app/assets/images/aon.png")  	
  	attachments['policy.pdf'] = AttachmentService.generate_pdf(renewal).render
  	mail(:from => @user.email_address, :to => @renewal.email_address, :subject => "#{@renewal.renewal_year} Motor Insurance Renewal - #{@renewal.expiry_date.to_s(:simple)}")
  end

  def korient_policy_reminder(renewal, user)  	
    @renewal = renewal
    @user = user
  	attachments.inline['korient.png'] = File.read("#{Rails.root}/app/assets/images/korient.png")  	
  	attachments['korient_policy.pdf'] = AttachmentService.generate_korient_pdf(renewal).render
  	mail(:from => @user.email, :to => @renewal.email_address, :subject => "#{@renewal.renewal_year} #{@renewal.product_type} - #{@renewal.expiry_date.to_s(:simple)}")
  end
end
