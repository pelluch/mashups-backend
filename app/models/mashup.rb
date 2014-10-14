class Mashup < ActiveRecord::Base
	has_many :links
	has_many :keywords
	
end
