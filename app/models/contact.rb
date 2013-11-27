require 'valid_email'
class Contact < ActiveRecord::Base
  belongs_to :user
  # validates  :phone_number, uniqueness: true, presence: :true
  # validates  :email, uniqueness: :true, presence: :true
  validates  :user, presence: :true
  validates  :name, presence: :true
  validates  :email, email: :true, uniqueness: :true, if: :has_email?
  validate :has_either_email_or_phone_number? 
  validate :has_valid_phone_number?
 
  def has_either_email_or_phone_number?
  	has_either = has_email? || has_phone_number? 
  	errors.add(:email, "Must at least have an email if no phone number is provided ") if !has_either
  end

  def has_valid_phone_number?
    state = PhoneConverter.is_valid?(self.phone_number)
    errors.add(:phone_number, "User must provide a valid phone number") if !state
  end

  def has_phone_number?
  	!phone_number.nil? && !phone_number.blank?
  end

  def has_email?
  	!email.nil? && !email.blank?
  end
end
