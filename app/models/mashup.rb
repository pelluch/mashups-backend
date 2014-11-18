class Mashup < ActiveRecord::Base

	has_many 	:links
	has_many 	:keywords
	
	belongs_to	:user

	#validates 	:name, :parameters, presence: true
	serialize 	:parameters, Array


	def generate params, sources
		params2 = ""
		
		params.each do |p|
			params2 += "#{p} "
		end
		params2 = params2[0..-2]
				
		a = ParserAIFacade::QueryManager.new
		objeto = a.parse_and_filter params2, sources, 10, 6


		objeto[:source_elements_by_relevance][0..15].each do |a|
			#puts "1.- Hash: #{a}"
			relevance = a['relevance']
			source_elem = a['source_element']
			
			source = source_elem['source']
			
			#puts source_elem['description']['type']
			id = LinkSource.find_by_name(source_elem['description']['type']).id
			id = id.to_i
			Link.create(link: source_elem['description']['url'], title: source_elem['content'], value: relevance, content: source_elem['description']['extra'], mashup_id: self.id, link_source_id: id)
		end

		objeto[:words_by_relevance][0..20].each do |a|
			#puts "1.- Hash: #{a}"
			keyword = a['word']
			value = a['relevance']
			Keyword.create(keyword: keyword, value: value, mashup_id: self.id)
		end
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
