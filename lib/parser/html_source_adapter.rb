require 'SourceAdapter'
class HtmlSourceAdapter < SourceAdapter
	@limit #limite de páginas que se van a buscar dentro de una fuente
	
	def initialize(query_params,url)
    	#String que contiene las palabras ingresadas por el usuario
    	super(query_params)
    	@url=url
    	@offset=0
  	end

	def getJSON(limit=20)
		ret=[]
		if limit<0
			raise 'limit no puede ser menor a cero'
		end

		while ret.length<limit
			nokogiri_html = self.getHtml
			json=buildJsonHtml(nokogiri_html)
			ret=ret + json
		end

		return ret[0,limit]
	end

  	def getHtml	
  		page = Nokogiri::HTML(open(@url))
  		return page
	end

	def nextHtml(offset)
		raise NotImplementedError.new('nextHtml debe ser implementado en una clase hija')
	end

	#Devuelve una lista de jsons
	def buildJsonHtml(html)		
		raise NotImplementedError.new('buildJsonHtml debe ser implementado en una clase hija')
	end
	
end
