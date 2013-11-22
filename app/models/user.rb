class User < ActiveRecord::Base
  has_many :items
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :company_name, :website, :email_address, :facebook_page, :twitter_handle, :phone_number, :alternate_phone_number

  validates_presence_of :company_name, :website, :phone_number, :email_address, on: :update
  
end
