class Contact < ActiveRecord::Base
  attr_accessible :confirmation_token, :confirmed_at, :email, :name, :subscribe
end
