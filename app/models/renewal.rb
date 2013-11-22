class Renewal < ActiveRecord::Base
	belongs_to :user, dependent: :destroy;
  # attr_accessible :amount_due, :city, :computation, :email_address, :expiry_date, :first_name, :last_name, :mobile_number, :postal_address, :ref, :registration_number, :renewal_date, :renewal_type, :value
  def renewal_year
  	expiry_date.year
  end
end
