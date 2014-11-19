module AI
	module TextAnalysers

		class AI::TextAnalysers::Textalytics < AI::TextAnalysers::Base

			MEDIA_API_HOST = "https://textalytics.com"
			MEDIA_API_URL = "/api/media/1.0/analyze"
			MEDIA_ANALYSIS_KEY = "0aa15ee8dc0ec1567fb6ebb48a60241f"

			def initialize

				@conn = HTTP::FaradayConnector.new MEDIA_API_HOST
				@counter = 0
				
				@source_types = {
					twitter: "TWITTER",
					emol: "NEWS"
				}
			end

			def textalytics_source_type(type)
				@source_types[type] || "UNKNOWN"
			end

			def analyse_text_batch(source_elements, query)
				results = []
				urls = []

				source_elements.each do |source_element|
					urls << generate_url(source_element)
					# results << analyse_text(source_element, query)
				end

				responses = @conn.post_parallel urls
<<<<<<< HEAD
=======
				responses.select! { |response| response.success }
				
>>>>>>> staging
				responses = responses.collect! do |response|
					{
						result: response.json["result"]
					}
				end
				
			end

			def analyse_text(source_element, query)

				url = generate_url(source_element)
				response = @conn.post url
				result = {
					source_element: source_element,
					result: response.json["result"]
				}

			end

			private

			def generate_url(source_element)
				doc = generate_doc(source_element)
				doc_url(doc)
			end

			def generate_doc(source_element)

				language = "es"
				doc = {
					document: {
						source: textalytics_source_type(source_element.description.type),
						language: language,
						id: 0,
						txt: source_element.content
					}
				}
			end

			def url_prefix
				"#{MEDIA_API_URL}?key=#{MEDIA_ANALYSIS_KEY}"
			end

			def doc_url(doc)
				"#{url_prefix}&doc=#{doc.to_json}"
			end

		end


	end

end