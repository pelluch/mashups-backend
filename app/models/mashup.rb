class Mashup < ActiveRecord::Base

	 before_destroy 	:destroy_associations

	has_many 	:links
	has_many 	:keywords
	
	belongs_to	:user

	#validates 	:name, :parameters, presence: true
	serialize 	:parameters, Array


	def generate params
		a = ParserAIFacade::QueryManager.new
		a.parse_and_filter params, [:cnn, :emol, :gobierno_de_chile, :twitter], 5
	end

	def self.clonar m1
		m2 = m1.dup

	    m1.links.each do |l|
	      link = l.dup
	      link.save
	      m2.links << link
	    end	    
	    m1.keywords.each do |l|
	      link = l.dup
	      link.save
	      m2.keywords << link
	    end
		m2    
	end


end
