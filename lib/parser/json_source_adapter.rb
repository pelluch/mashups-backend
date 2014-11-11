class JSONSourceAdapter < SourceAdapter

	def initialize(query_params,url)
    	#String que contiene las palabras ingresadas por el usuario
    	super(query_params)
    	@url=url
    	@offset=0
  	end

	def getJSONImplement(limit)
		ret = []
		if limit <0
			raise "Limit debe ser mayor a 0"
		end
		result = getAPIJSON().body
		# puts result
		# puts parsedData
		ret = buildJSONAPI(result, limit)
		return ret
	end

	def getAPIJSON
		
	end
	
	def buildJSONAPI(parsedData, limit)
	
	end
end