class Mashup < ActiveRecord::Base
	has_many 	:links
	has_many 	:keywords
	
	belongs_to	:user

	serialize 	:parameters, Array
end
