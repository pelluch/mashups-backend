class CNNSourceAdapter < HtmlSourceAdapter
@searchURI
@params

	def initialize(query_params)
		query=query_params
		super(query_params, create_url(query_params, 0))
	end

	def buildJsonHtml(nokogiri_html)
		ret = []
		nokogiri_html.css('.results li').map do |res|
  			title=res.css('a').text.strip 	#.encode("UTF-8")
  			content=res.css('.content p').text
  			date = res.css('.meta').text
  			#source
  			url= "http://www.cnnchile.com/" + res.css('a').attribute('href').to_s
  			type = 'cnn'

  			json={ 'content' => content,'date' => date,'source'=> {'url'=> url, 'type' => type, 'extras' => title}}.to_json
  			ret.append(json)
  		end

  		return ret
	end

	def nextHtml(current_nokogiri_html)
		@offset=@offset+1
		@url=create_url(@query_params,@offset)
		return getHtml()
	end

	def create_url(query_params=nil, offset=0)
		query_params=query_params==nil ? @query : query_params
		return URI::encode("http://www.cnnchile.com/buscar/key/#{query_params}/p/#{offset + 1}")
	end

end
