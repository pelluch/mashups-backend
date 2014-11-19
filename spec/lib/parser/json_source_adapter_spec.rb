require 'rails_helper'
require "net/http"



classes=[GovDataSourceAdapter,TwitterSourceAdapter]


classes.each do |class_|

	describe class_ do 
		context 'when I look for parameters that do not exist' do
			it "should not return null" do
				e=class_.new('elkjrfnwekjndwelkjndwlkejdnwlqkjndlkwqjnedejkwqdnwqelkj')
				expect(e.getJSON(10,900)!=nil).to be true
			end
			it "should return empty array" do
				e=class_.new('elkjrfnwekjndwelkjndwlkejdnwlqkjndlkwqjnedejkwqdnwqelkj')
				expect(e.getJSON(10,900).count==0).to be true
			end
		end

		context 'when I search 5 results and exist' do
			it "should return 5 results" do
				e=class_.new('mario')
				expect(e.getJSON(10,5).count==5).to be true
			end
		end

		context 'when I search 50 results and not exist' do
			it "should return 50 or less results" do
				e=class_.new('mario bros')
				expect(e.getJSON(10,50).count<=50).to be true
			end
		end

		context 'when i build json from api' do
			it "getAPIJSON should return a not null url" do
				e=class_.new('mario')
				ret = e.getAPIJSON
				expect(ret!=nil).to be true
			end
			
		end

	


	end
end