require 'rails_helper'
require "net/http"



classes=[EmolSourceAdapter,CNNSourceAdapter,BBCSourceAdapter,GoodReadsSourceAdapter]


classes.each do |class_|

	describe class_ do 
		context 'when I look for parameters that do not exist' do
			it "should return empty result" do
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

		context 'when i build json from html' do
			it "create_url should return a not null url" do
				e=class_.new('mario')
				url = e.create_url
				expect(url!=nil).to be true
			end
			it "create_url should return an active url" do
				e=class_.new('mario')
				url =  URI.parse(e.create_url)
				req = Net::HTTP.new(url.host, url.port)
				res = req.request_head(url.path)
				expect(res.code=="200").to be true
			end
		end

		it "getHtml should return not null value" do
			e=class_.new('mario')
			nk=e.getHtml
			expect(nk!=nil).to be true
		end


	end
end