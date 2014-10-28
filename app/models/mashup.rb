class Mashup < ActiveRecord::Base
	has_many 	:links
	has_many 	:keywords
	
	belongs_to	:user

	validates 	:name, :parameters, presence: true
	serialize 	:parameters, Array

	def parser
		
	end
end
