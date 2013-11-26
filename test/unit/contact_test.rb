require 'test_helper'

class ContactTest < ActiveSupport::TestCase
	# before do
		# @user = User.new :email_address => "test@domain.com"	
	# end

	test "A contact must have a name" do
		@contact = Contact.new :name => nil

		assert_equal @contact.valid?, false
	end
end