class HtmlSourceAdapter < SourceAdapter
	@limit #limite de páginas que se van a buscar dentro de una fuente
	
	def initialize(query_params,url)
    	#String que contiene las palabras ingresadas por el usuario
    	super(query_params)
    	@url=url
  	end

	def getJSON(limit)

	end

  	def getHtml	
  		page = Nokogiri::HTML(open(@url))   
	end

	def nextHtml(offset)	

	end

	def buildJsonHtml(html)		

	end
	
	def putParamsInExtra(params)

	end
end
