module AI
	module TextAnalysers

		class AI::TextAnalysers::Textalytics < AI::TextAnalysers::Base

			MEDIA_API_HOST = "https://textalytics.com"
			MEDIA_API_URL = "/api/media/1.0/analyze"
			MEDIA_ANALYSIS_KEY = "0aa15ee8dc0ec1567fb6ebb48a60241f"

			def initialize
				@source_types = {
					twitter: "TWITTER",
					emol: "NEWS"
				}
			end

			def textalytics_source_type(type)
				@source_types[type] || "UNKNOWN"
			end

			#def analyse_text(url, language = "es", source = "TWITTER", fields = "")
			def analyse_text(source_element, query)

				language = "es"
				

				doc = {
					document: {
						source: textalytics_source_type(source_element.description.type),
						language: language,
						id: 0,
						txt: query
					}
				}

				body = {
					key: MEDIA_ANALYSIS_KEY,
					doc: doc
				}

				conn = HTTP::FaradayConnector.new MEDIA_API_HOST
				url = "#{MEDIA_API_URL}?key=#{MEDIA_ANALYSIS_KEY}&doc=#{doc.to_json}"
				response = conn.post url
				result = response.json["result"]

			end

		end


	end

end