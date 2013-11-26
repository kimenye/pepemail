require 'valid_email'
class Contact < ActiveRecord::Base
  belongs_to :user
  # validates  :phone_number, uniqueness: true, presence: :true
  # validates  :email, uniqueness: :true, presence: :true
  validates  :user, presence: :true
  validates  :name, presence: :true
  validates  :email, email: :true, uniqueness: :true, if: :has_email?

  def has_email?
  	!email.nil? || !email.blank?
  end
end