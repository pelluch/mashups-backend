class GovDataSourceAdapter < JSONSourceAdapter
@searchURI
@params
	def getAPIJSON() #FALTA IMPLEMENTAR REQUEST, ESTA FALLA
		uri = URI.parse("http://api.recursos.datos.gob.cl/datastreams/search?query=@query&auth_key=05579a63c4aea8106f4e2f19726255c45ddf689a")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
		@data = http.get(uri.request_uri)
		return @data
	end

	def buildJSONAPI(parsedData, limit)
		ret = []
		parsedData["description"].each do |desc|
			@contents << desc
		end
		parsedData["title"].each do |titl|
			@titles << titl
		end
		parsedData["link"].each do |l|
			@urls << l
		end
		parsedData["created_at"].each do |cat|
			@dates << cat
		end
		parsedData["tags"].each do |t|
			@tags << t
		end
		i = 0
		type = gobierno_de_chile
		while (i < limit && i < contents.length)
			json={'source' => nil, 'title'=>  titles[i], 'content' => contents[i],'date' => dates[i],'source'=> {'url'=> urls[i], 'type' => type, 'extras' => tags[i]}}.to_json
			ret << json
		end
		return ret
	end
end