class TwitterSourceAdapter < JSONSourceAdapter
@searchURI
@params

	def initialize(query_params, url = "")

		super(URI.encode(query_params), url)
	end

@next
def getAPIJSON()
	updateUri()
	request = Net::HTTP::Get.new @searchURI
	request.add_field("Authorization", getOAUTH())
	http = Net::HTTP.new(@searchURI.host, @searchURI.port)
	http.use_ssl = true
	response = http.request(request)
	response
end

def buildJSONAPI(result, limit)
	ret =[]

	parsedData = JSON.parse(result)
	@next = parsedData["search_metadata"]["next_results"]
	@next = @next[1, @next.length]
	parsedData = parsedData["statuses"]
	parsedData.each do |article|

		json = {
			'author' => article["user"]["name"],
			'date' => article["created_at"],
			'title'=>  article["text"], 'content' => article["text"],
			'source'=> {
				'url'=> "https://twitter.com/N3R4S2/status/#{article["id"]}",
				'type' => "twitter",
				'extras' => article["user"]["followers_count"]
				}
			}.to_json
		ret << json
		
	end

	if limit > 15 and ret.length >= 15
		response = getAPIJSON().body
		ret2 = buildJSONAPI(response, limit - 15)
		ret2.each do |p|
			ret << p
		end
	end

	ret
end

private
def updateUri()
	if @params.nil?
		@params = @query
	end
	if @next.nil?
		@searchURI = "https://api.twitter.com/1.1/search/tweets.json?q=#{@params}"
	else
		@searchURI = "https://api.twitter.com/1.1/search/tweets.json?#{@next}"
	end
	@searchURI = URI.parse(@searchURI)
end

def getOAUTH()
	oauth_consumer_key = "RLRZyeUMC0aWqOMQZyyBkpkKZ"
	oauth_nonce = SecureRandom.hex.downcase
	oauth_signature_method = "HMAC-SHA1"
	oauth_timestamp = Time.now.to_i.to_s
	oauth_token = "2393279576-J0rVwOHFP1oFbkpNq2kVQGFYHvgxGFhzC2kiDji"
	oauth_version = "1.0"

	oauth_signature_value = ""
	if not @next.nil?
		spt = @next.split("&")
		oauth_signature_value += spt[2]
		oauth_signature_value += "&"
		oauth_signature_value += spt[0]
		oauth_signature_value += "&"
	end
	oauth_signature_value += "oauth_consumer_key=" + oauth_consumer_key
	oauth_signature_value += "&oauth_nonce=" + oauth_nonce
	oauth_signature_value += "&oauth_signature_method=" + oauth_signature_method
	oauth_signature_value += "&oauth_timestamp=" + oauth_timestamp
	oauth_signature_value += "&oauth_token=" + oauth_token 
	oauth_signature_value += "&oauth_version=" + oauth_version
	oauth_signature_value += "&q=" + @params

	oauth_signature_value = "GET&"+ CGI.escape("https://api.twitter.com/1.1/search/tweets.json") + "&" + CGI.escape(oauth_signature_value)

	oauth_signature_key = "BOJ2V9b6Wxe38PmzsH984E8QFRUnqEhNdeghhVmS1p9HjsHKR8" + "&" + "9NabTSTuQza3efM66wyN3J4alSix0fNZqFD3W4xQBDTmG"
	
	oauth_signature = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', oauth_signature_key, oauth_signature_value)))
	oauth_signature = oauth_signature.split("%3D")[0] + "%3D"

	oauth  = 'OAuth oauth_consumer_key="' + oauth_consumer_key
	oauth += '", oauth_nonce="' + oauth_nonce
	oauth += '", oauth_signature="' + oauth_signature
	oauth += '", oauth_signature_method="' + oauth_signature_method
	oauth += '", oauth_timestamp="'+ oauth_timestamp
	oauth += '", oauth_token="' + oauth_token
	oauth += '", oauth_version="' + oauth_version
	oauth += '"'
	oauth
end
end