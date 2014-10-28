class TwitterSourceAdapter < JSONSourceAdapter
@searchURI
@params
@next
def getAPIJSON()
	@params = "perro"
	request = Net::HTTP::Get.new @searchURI
	request.add_field("Authorization", getOAUTH())
	puts @params
	http = Net::HTTP.new(@searchURI.host, @searchURI.port)
	http.use_ssl = true
	http.set_debug_output $stderr
	response = http.request(request)
	response
end

def buildJSONAPI(result, limit)
	ret = []
	
	return ret
end

private
def updateUri()
	@searchURI = "https://api.twitter.com/1.1/search/tweets.json?q=#{@params}"
	@searchURI = URI.parse(@searchURI)
end

def getOAUTH()
	#hay que arreglarlo...
	oauth_consumer_key = "RLRZyeUMC0aWqOMQZyyBkpkKZ"
	oauth_nonce = SecureRandom.urlsafe_base64
	oauth_signature_method = "HMAC-SHA1"
	oauth_timestamp = Time.now.to_i.to_s
	oauth_token = "2393279576-J0rVwOHFP1oFbkpNq2kVQGFYHvgxGFhzC2kiDji"
	oauth_version = "1.0"

	oauth_signature_value = "oauth_consumer_key=" + oauth_consumer_key
	oauth_signature_value += "&oauth_nonce=" + oauth_nonce
	oauth_signature_value += "&oauth_signature_method=" + oauth_signature_method
	oauth_signature_value += "&oauth_timestamp=" + oauth_timestamp
	oauth_signature_value += "&oauth_token=" + oauth_token 
	oauth_signature_value += "&oauth_version=" + oauth_version
	oauth_signature_value += "&q=" + @params

	oauth_signature_value = "GET&"+ CGI.escape("https://api.twitter.com/1.1/search/tweets.json") + "&" + CGI.escape(oauth_signature_value)

	oauth_signature_key = CGI.escape("BOJ2V9b6Wxe38PmzsH984E8QFRUnqEhNdeghhVmS1p9HjsHKR8") + "&" + CGI.escape("9NabTSTuQza3efM66wyN3J4alSix0fNZqFD3W4xQBDTmG")
	
	oauth_signature = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', oauth_signature_key, oauth_signature_value)))
	oauth_signature = oauth_signature.split("%3D")[0] + "%3D"

	oauth  = 'OAuth oauth_consumer_key=' + oauth_consumer_key
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