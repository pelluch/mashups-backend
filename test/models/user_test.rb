require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	test "user should not be saved with name's length out of valid range" do
		user = User.new

		user.name = 'aa';
		assert_not user.save

		user.name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
		assert_not user.save
	end

	test "user should not be saved with mail written in wrong format" do
		user = User.new
		user.mail = "slfjkladsfjdaslfja";
		assert_not user.save
	end

	test "user should be saved when all the paremeters are written right" do
		user = User.new
		user.name = "random_name"
		user.mail = "random@mail.com"
		user.password = "password"
	end

end