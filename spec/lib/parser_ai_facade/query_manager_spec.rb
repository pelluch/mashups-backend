require 'rails_helper'

RSpec.describe "QueryManager" do

    describe :parse_and_filter do

        let(:search_params) { [ "twitter" ]}
        let(:query) { "Alexis Sanchez futbol" }        
        let(:limit) { 1 }
        let(:query_manager) { ParserAIFacade::QueryManager.new }
    
        it "Should not raise an exception" do
        	expect { query_manager.parse_and_filter(query, 
        		search_params, 10000, limit) }.not_to raise_error
        end

    end

end
