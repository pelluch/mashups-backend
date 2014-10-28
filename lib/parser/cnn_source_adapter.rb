class CNNSourceAdapter < HtmlSourceAdapter
@searchURI
@params

	def initialize(query_params)
		query=query_params
		@offset=0
		super(query_params, create_url(query_params, @offset))
	end

	def buildJsonHtml(nokogiri_html)
		ret = []
	end

	def nextHtml(current_nokogiri_html)
		@offset=@offset+1
		@url=create_url(@query_params,@offset)
		return getHtml()
	end

	def create_url(query_params=nil, offset=0)
		query_params=query_params==nil ? @query : query_params
		return URI::encode("http://www.cnnchile.com/buscar/key/#{query_params}/p/#{offset}")
	end

end
