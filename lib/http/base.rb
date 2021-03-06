module HTTP
    class Base

        # Wraps around a certain http library
        @type

        def initialize(host)
            @host = host
        end

        def get(url, params = {}, opts = {})
        end

        def post(url, params = {}, opts = {})
        end

        def put(url, params = {}, opts = {})
        end

        def request(url, params = {}, opts = {})
        end

        def patch(url, params = {}, opts = {})
        end
        
    end
end