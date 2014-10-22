module AI
	module TextAnalysers

		class Textalytics < AI::TextAnalysers::Base

			MEDIA_API_URL = "https://textalytics.com"
			MEDIA_ANALYSIS_KEY = "0aa15ee8dc0ec1567fb6ebb48a60241f"

			def analyse_text(url, language = "es", source = "TWITTER", fields = "")

				doc = {
					source: source,
					language: language,
					id: 0,
					txt: "Me gustan los deportes como el futbol"
				}

				body = {
					key: MEDIA_ANALYSIS_KEY
				}

				conn = Faraday.new url: MEDIA_API_URL
				conn.post do |req|
					req.url "/api/media/1.0/analyze"
					req.headers['Content-Type'] = 'application/json'
				end
			end

		end

	end

end