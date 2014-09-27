module AI
	module SourceAnalysers
		class Emol < AI::SourceAnalysers::Base

			def analyse_source(source_element, query)
				Rails.logger.info("Unimplemented")
			end

			def title_vs_query_score(source_element, query)
				Rails.logger.info("Unimplemented")
			end
			
		end
	end
end