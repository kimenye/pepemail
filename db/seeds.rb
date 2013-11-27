user = User.find_by_email("hello@pepemail.co.ke")
user = User.create! :name => "Test",:email => "hello@pepemail.co.ke", :email_address => "hello@pepemail.co.ke", :password => "password", :password_confirmation => "password", :company_name => "sprout", :website => "www.pepemail.co.ke", :phone_number => "0722969148" if user.nil?
user.is_admin = true
user.save!
