module AI
	module SourceAnalysers
		class Base

            # Base method for analysing a source such as twitter or EMOL
			def analyse_source(source_element, query)
				Rails.logger.info("Unimplemented")
			end
		end
	end
end