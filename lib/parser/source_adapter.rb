class SourceAdapter
	# @searchURI
	# @params #hash que es diferente para cada fuente, donde la llave es el parámetro que se quiere y el valor es como llegar
	# 		#a él. Por ejemplo una llave puede ser título y el valor es la ruta completa para llegar al titulo de acuerdo a
	# 		#esa fuente

	def initialize(query_params)
    	#String que contiene las palabras ingresadas por el usuario
    	@query=query_params

  	end

	def getJSON(limit)
		raise NotImplementedError.new('getJSON debe ser implementado en una clase hija')
	end

end