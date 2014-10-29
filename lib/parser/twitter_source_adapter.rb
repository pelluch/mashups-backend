class TwitterSourceAdapter < HtmlSourceAdapter
@searchURI
@params

	def initialize query_params
		super(query_params, "")
	end
end