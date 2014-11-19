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
  ret = []
  parsedData = JSON.parse result
  getNext parsedData
  parsedData = parsedData["statuses"]
  parsedData.each do |article|
    ret.append(build_json_twitter article)
  end

  if limit > 15 and ret.length >= 15
    ret += buildJSONAPI(getAPIJSON.body, limit - 15)
  end
  return ret[0,limit]
end

private
# => To add/remove information from the response, change this method
def build_json_twitter article
  json = {
    'author' => article["user"]["name"],
    'date' => article["created_at"],
    'title'=>  article["text"],
    'content' => article["text"],
    'source'=> {
      'url'=> "https://twitter.com/N3R4S2/status/#{article["id"]}",
      'type' => "twitter",
      'extras' => article["user"]["followers_count"]
    }
  }.to_json
  json
end

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

def getNext parsedData
  @next = parsedData["search_metadata"]["next_results"]
  @next = @next[1, @next.length]
end

def get_OAUtH_signature_params params
  if @next.nil?
    oauth_signature_value = ""
  else 
    spt = @next.split("&")
    oauth_signature_value = spt[2] + "&" + spt[0] + "&"
  end
  params.each{|key,value| oauth_signature_value += key.to_s + "=" + value + "&" }
  oauth_signature_value += "q=" + @params
  oauth_signature_value
end

def get_OAUTH_signature_value params
  oauth_signature_params = get_OAUtH_signature_params params
  oauth_signature_value = "GET&"+ CGI.escape("https://api.twitter.com/1.1/search/tweets.json") + "&" + CGI.escape(oauth_signature_params)
  oauth_signature_value
end

def get_OAUTH_signature params
  oauth_signature_value = get_OAUTH_signature_value params
  oauth_signature_key = "BOJ2V9b6Wxe38PmzsH984E8QFRUnqEhNdeghhVmS1p9HjsHKR8" + "&" + "9NabTSTuQza3efM66wyN3J4alSix0fNZqFD3W4xQBDTmG"
  oauth_signature = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', oauth_signature_key, oauth_signature_value)))
  oauth_signature = oauth_signature.split("%3D")[0] + "%3D"
  oauth_signature
end

def getHeaderOAUTH params
  oauth = 'OAuth '
  params.each{|key,value| oauth += key.to_s + "=\"" + value + "\"," }
  oauth
end

def getOAUTH()
  # Params
  params = {
    :oauth_consumer_key     => "RLRZyeUMC0aWqOMQZyyBkpkKZ",
    :oauth_nonce            => SecureRandom.hex.downcase,
    :oauth_signature_method => "HMAC-SHA1",
    :oauth_timestamp        => Time.now.to_i.to_s,
    :oauth_token            => "2393279576-J0rVwOHFP1oFbkpNq2kVQGFYHvgxGFhzC2kiDji",
    :oauth_version          => "1.0"
  }

  # Signature
  params[:oauth_signature] = get_OAUTH_signature params

  # Header
  return getHeaderOAUTH params
end
end