class BBCSourceAdapter < HtmlSourceAdapter
	@searchURI
	@params

	def initialize(query_params)
    	#String que contiene las palabras ingresadas por el usuario
    	@query=query_params
    	super(query_params,create_url(query_params,1))
    	@offset = 1
  	end


  	def buildJsonHtml(nokogiri_html)
  		ret=[]	

  		nokogiri_html.css(".hard-news-unit").map do |res|
  			title = res.css(".hard-news-unit__headline").text.squish.gsub("\"", "").encode("UTF-8")
  			content = res.css(".hard-news-unit__body").text.squish.gsub("\"", "").encode("UTF-8")
  			date = res.css(".date").text.strip.encode("UTF-8")
  			#source
  			url= res.css(".hard-news-unit__headline a").attribute("href").to_s.encode("UTF-8")
  			type = 'bbc'

  			json = {'author' => nil, 'date' => date, 'content' => content, 'source'=> {'url'=> url, 'type' => type, 'extras' =>  title}}.to_json
  			ret << json
  		end

  		return ret
	end

	def nextHtml(current_nokogiri_html)
		#offset_text tiene la forma "Resultados 1 al 17 de 8.828"
		@offset= @offset + 10
		@url=create_url(@query,@offset)
		return getHtml()

	end

	def create_url(query_params=nil,offset=1)
		query_params=query_params==nil ? @query_params : query_params
		return URI::encode("http://www.bbc.co.uk/mundo/search/?q=#{query_params}&start=#{offset}")
	end
end