class JSONSourceAdapter < SourceAdapter

	def initialize(query_params,url)
    	#String que contiene las palabras ingresadas por el usuario
    	super(query_params)
    	@url=url
    	@offset=0
  	end

	def getJSON(limit)
		ret = []
		if limit <0
			raise "Limit debe ser mayor a 0"
		end
		result = getAPIJSON()
		puts result
		parsedData = JSON.parse(result)
		ret = buildJSONAPI(parsedData, limit)
		return ret[0,limit] #Con esto igual se devuelve el límite, conversar eficiencia sobre el while
	end

	def getAPIJSON
		
	end
	
	def buildJSONAPI(parsedData, limit)
	
	end
end