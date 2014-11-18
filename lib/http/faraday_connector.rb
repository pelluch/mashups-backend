module HTTP
    class FaradayConnector < HTTP::Base

        def initialize(host)
            super
            @conn = Faraday.new url: host
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

        def post(url, params = {}, opts = {})
            begin
                response = @conn.post do |req|
                    req.url url
                    req.headers['Content-Type'] = 'application/json'
                    req.body = params.to_json
                end
                get_response response
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