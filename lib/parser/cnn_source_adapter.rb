class CNNSourceAdapter < HtmlSourceAdapter
@searchURI
@params

	def initialize(query_params)
		query=query_params
		super(query_params, create_url(query_params, 0))
	end

	def buildJsonHtml(nokogiri_html)
		ret = []
	end

	def nextHtml(current_nokogiri_html)

	end

	def create_url(query_params=nil, offset=0)
		query_params=query_params==nil ? @query : query_params

		return URI::encode("http://edition.cnn.com/search/?query=#{query_params}&x=0&y=0&primaryType=mixed&sortBy=relevance&intl=true#&sortBy=date")
	end

end
