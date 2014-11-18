class GoodReadsSourceAdapter < HtmlSourceAdapter
@searchURI
@params

	def initialize(query_params)
    	#String que contiene las palabras ingresadas por el usuario
    	@query=query_params
    	super(query_params,create_url(query_params,0))
  	end


  	def buildJsonHtml(nokogiri_html)
  		ret=[]	
  		nokogiri_html.css(".tableList tr").map do |res|
  			title=res.css(".quoteText a").text.strip 	#.encode("UTF-8")
  			content=res.css(".quoteText").text.strip 
  			date = nil
  			#source
  			url= "https://www.goodreads.com/" + res.css("a").attribute('href').to_s
  			type = 'goodreads'

  			json={'content' => content,'date' => date,'source'=> {'url'=> url, 'type' => type, 'extras' =>  title}}.to_json
  			ret.append(json)
  		end

  		return ret
	end

  def getHtml
    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE 
    http.open_timeout = 5 #Segundos por request
    http.read_timeout = 5 #Segundos por request
    response = http.get(uri)
    page = Nokogiri.parse(response.body)

    return page


    
  end

	def nextHtml(current_nokogiri_html)
		#offset_text tiene la forma "Resultados 1 al 17 de 8.828"
		offset_text=current_nokogiri_html.css(".current").text
		offset=offset_text + 1;
		@url=create_url(@query,offset)
		return getHtml()

	end

	def create_url(query_params=nil,offset=1)
		query_params=query_params==nil ? @query_params : query_params
		return URI::encode("https://www.goodreads.com/search?page=#{offset}&q=#{query_params}&search%5Bsource%5D=goodreads&search_type=quotes&tab=quotes")
	end
end