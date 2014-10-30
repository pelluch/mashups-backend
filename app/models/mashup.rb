class Mashup < ActiveRecord::Base

	has_many 	:links
	has_many 	:keywords
	
	belongs_to	:user

	#validates 	:name, :parameters, presence: true
	serialize 	:parameters, Array


	def generate params
		params2 = ""

		params.each do |p|
			params2 += "#{p} "
		end

		params2 = params2[0..-2]

		self.update(parameters: params)

		a = ParserAIFacade::QueryManager.new
		objeto = a.parse_and_filter params2, ['cnn', 'emol', 'gobierno_de_chile', 'twitter'], 5

		puts objeto[:words_by_relevance]
		puts objeto[:source_elements_by_relevance]
	end

	def self.clonar m1
		m2 = m1.dup
		m2.save
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
