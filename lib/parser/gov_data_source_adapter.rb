class GovDataSourceAdapter < JSONSourceAdapter
@searchURI
@params
	def getAPIJSON() #FALTA IMPLEMENTAR REQUEST, ESTA FALLA
		url = "http://api.recursos.datos.gob.cl/datastreams/search?query=" + @query + "&auth_key=05579a63c4aea8106f4e2f19726255c45ddf689a"
		uri = URI.parse(url)
		# Net::HTTP.get_print(uri)
		http = Net::HTTP.new(uri.host, uri.port)
		response = http.request(Net::HTTP::Get.new(uri.request_uri))
		return response
	end

	def buildJSONAPI(result, limit)
		ret = []
		contents = []
		titles = []
		urls = []
		dates = []
		# tags = []
		parsedData = JSON.parse(result)
		parsedData.each do |article|
			contents << article["description"]
			titles << article["title"]
			urls << article["link"]
			dates << article["created_at"]
			# tags << article["tags"]
		end
		i = 0
		type = "gobierno_de_chile"
		while (i < limit && i < contents.length)
			json = {'author' => nil, 'date' => dates[i], 'content' => contents[i],'source'=> {'url'=> urls[i], 'type' => type, 'extras' => titles[i]}}.to_json
			ret << json
			i += 1
		end
		return ret
	end
end