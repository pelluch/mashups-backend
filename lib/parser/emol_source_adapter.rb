class EmolSourceAdapter < HtmlSourceAdapter
@searchURI
@params

  def initialize(query_params)
      #String que contiene las palabras ingresadas por el usuario
      query=query_params
      super(query_params,create_url(query_params))
    end


    def buildJsonHtml(nokogiri_html)
      ret=[]  
      nokogiri_html.css(".resultado").map do |res|
        title=res.css(".title").text.strip  #.encode("UTF-8")
        content=res.css(".teaser").text.strip 
        date = /[0-9]{2}\/[0-9]{2}\/[0-9]{2}/.match(res.css(".fecha_noticia").text).to_s.to_datetime
        #source
        url= res.css(".title a").attribute('href').to_s
        type = 'emol'

        json={'title'=>  title, 'content' => content,'date' => date,'source'=> {'url'=> url, 'type' => type}}.to_json
        ret.append(json)
      end

      nextHtml(nokogiri_html)

      return ret
  end

  def nextHtml(current_nokogiri_html)
    @offset += 10
    @url=create_url(@query,@offset)
  end

  def create_url(query_params=nil,offset=0)
    query_params ||= @query
    return URI::encode("http://buscador.emol.com/dispatcher.php?query=#{query_params}&query2=&offset=#{offset}&portal=todos&sort=rank&sortdir=descending&por=EMOL&o2=13&o3=25&o4=35&cn=emol&Submit=Buscar")
  end

end
