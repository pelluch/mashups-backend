require 'typhoeus/adapters/faraday'

module HTTP
    class FaradayConnector < HTTP::Base

        def initialize(host)
            super

            manager = Typhoeus::Hydra.new(max_concurrency: 100)
            @conn = Faraday.new url: host do |builder|
                builder.adapter :typhoeus
            end
        end

        def get_response(faraday_response)
            HTTP::Response.new status: faraday_response.status, body: faraday_response.body, success: true
        end

        def get(url, params = {}, opts = {})

            begin
                response = @conn.get do |req|
                    req.url url
                    req.params = params
                end
                get_response response
            rescue Faraday::Error::ConnectionFailed => e
                return HTTP::Response.new success: false, error: e.message
            end            
        end

        def post_parallel(urls, params = {}, opts = {})
            responses = []
            grouped_urls = urls.each_slice(5).to_a

            grouped_urls.each do | url_group| 
                time1 = Time.new
                @conn.in_parallel do
                    url_group.each do |url|
                        responses << raw_post(url, params, opts)
                    end
                end
                time2 = Time.now
                sleep_time = time1 - time2 + 1.0
                if sleep_time > 0
                    sleep sleep_time
                end
            end           

            responses.collect! do |response|
                get_response(response)
            end

        end

        def post(url, params = {}, opts = {})
            response = raw_post(url, params, opts)
            get_response(response)
        end

        def raw_post(url, params = {}, opts = {})
            begin
                response = @conn.post do |req|
                    req.url url
                    req.headers['Content-Type'] = 'application/json'
                    req.body = params.to_json
                end
                response
            rescue Faraday::Error::ConnectionFailed => e
                return HTTP::Response.new success: false, error: e.message
            end
        end

        def put(url, params = {}, opts = {})
            begin
                response = @conn.put do |req|
                    req.url url
                    req.headers['Content-Type'] = 'application/json'
                    req.body = params.to_json
                end
                get_response response
            rescue Faraday::Error::ConnectionFailed => e
                return HTTP::Response.new success: false, error: e.message
            end
        end

        def request(url, params = {}, opts = {})
        end

        def patch(url, params = {}, opts = {})
            begin

            rescue Faraday::Error::ConnectionFailed => e
                return nil
            end
        end
        
    end
end