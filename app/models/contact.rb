class Contact < ActiveRecord::Base
  belongs_to :user
  validates  :phone_number, uniqueness: true, presence: :true
  validates  :email, uniqueness: :true, presence: :true
  validates  :user, presence: :true
  validates  :name, presence: :true

end
