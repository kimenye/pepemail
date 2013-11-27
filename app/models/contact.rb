require 'valid_email'
class Contact < ActiveRecord::Base
  belongs_to :user
  validates  :user, presence: :true
  validates  :phone_number, uniqueness: :true  
  validates  :email, email: :true, uniqueness: :true, if: :has_email?
  validate   :has_either_email_or_phone_number? 
  validate   :has_valid_phone_number?, if: :has_phone_number?

  def has_either_email_or_phone_number?
  	has_either = has_email? || has_phone_number? 
  	errors.add(:email, "Must at least have an email if no phone number is provided ") if !has_either
  end

  def has_valid_phone_number?
    is_valid = PhoneConverter.is_valid?(phone_number)
    errors.add(:phone_number, "User must provide a valid phone number") if !is_valid 
  end

  def has_phone_number?
  	!phone_number.nil? && !phone_number.blank?
  end

  def has_email?
  	!email.nil? && !email.blank?
  end
end
