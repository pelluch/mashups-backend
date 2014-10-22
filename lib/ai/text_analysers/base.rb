module AI
	module TextAnalysers
		class Base

            attr_reader :api_url, :api_key, :api_secret

            def analyse_text(text, query)
            end
		end
	end
end
