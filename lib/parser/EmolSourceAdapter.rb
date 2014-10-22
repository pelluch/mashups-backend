class EmolSourceAdapter < HtmlSourceAdapter
@searchURI
@params

	def initialize(query_params)
    	#String que contiene las palabras ingresadas por el usuario
    	query=q
    	super(query_params,URI::encode("http://buscador.emol.com/dispatcher.php?query=#{query_params}&query2=&offset=13&portal=todos&sort=rank&sortdir=descending&por=EMOL&o2=13&o3=25&o4=35&cn=emol&Submit=Buscar"))
  	end

  	def buildJsonHtml(nokogiri_html)
  		ret=[]	
  		page.css(".resultado").map do |res|
  			title=res.css(".title").text.strip 	#.encode("UTF-8")
  			content=res.css(".teaser").text.strip 
  			date = /[0-9]{2}\/[0-9]{2}\/[0-9]{2}/.match(res.css(".fecha_noticia").text).to_s.to_datetime
  			#source
  			url= first.css(".title a").attribute('href').to_s
  			type = 'emol'


  			json=JSON.parse('{"title": #{title}, "content": #{content},"date":#{date},"source":{"url":#{url}, "type":#{type}}}')
  			ret.append
  		end
  		
  		return ret
	end

end
