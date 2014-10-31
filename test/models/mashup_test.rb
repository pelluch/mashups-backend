require 'test_helper'

class MashupTest < ActiveSupport::TestCase

	test "mashup should be saved" do
		mashup = Mashup.new
		assert mashup.save
	end

end
