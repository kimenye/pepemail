require 'test_helper'

class ContactTest < ActiveSupport::TestCase
	before do
		@user = User.new :email => "test@domain.com", :password => "p@ssword"
		@user.save!
	end

	test "A contact must have a user" do
		@contact = Contact.new :name => nil, :email => "me@you.com", :phone_number => "0722866564", :user => nil
		assert_equal false, @contact.valid?
	end

	test "A contact must have a valid email address if it is specified" do
		@contact = Contact.new :name => "My name", :email => "jkldfslkjsdf", :phone_number => "0722866564", :user => @user
		assert_equal false, @contact.valid?

		@contact.email = nil
		assert_equal true, @contact.valid?				

		@contact.email = "me@you.com"
		assert_equal true, @contact.valid?				
	end

	test "A contact must have a unique email address if it is specified" do
		Contact.delete_all
		@contact = Contact.create! :name => "My name", :email => "me@you.com", :phone_number => "0722866564", :user => @user	

		@new = Contact.new :name => "Other", :email => "me@you.com", :phone_number => "0722866564", :user => @user	
		assert_equal false, @new.valid?
	end

        test "A contact must have a unique phone number if it is specified" do
		Contact.delete_all
		@contact = Contact.create! :name => "My name", :email => "us@you.com", :phone_number => "0722866564", :user => @user	

		@new = Contact.new :name => "Other", :email => "me@you.com", :phone_number => "0722866564", :user => @user	
		assert_equal false, @new.valid?
	end

	test "A contact must have at least either a valid email address or a phone number" do
		@contact = Contact.new :name => "My name", :email => nil, :phone_number => nil, :user => @user	

		assert_equal false, @contact.valid?

		@contact.phone_number = "0722866564"
		assert_equal true, @contact.valid?		

		@contact.phone_number = nil
		@contact.email = "me@you.com" 
		assert_equal true, @contact.valid?		

		@contact.phone_number = "0722866564"
		@contact.email = "me@you.com"
		assert_equal true, @contact.valid?		
	end

	test "A phone number is valid if it passes the phone validation test" do
		@contact = Contact.new :name => "My Name", :user => @user
		@contact.phone_number = "254xxxxxxx"

		assert_equal false, @contact.valid?
	end
end
