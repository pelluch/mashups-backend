class HTTP::Response

    attr_accessor :success, :error, :body, :status, :type, :json, :data

    def initialize(params = {})
        params.each do |key, value|
            instance_variable_set("@#{key}", value)
        end

        @json ||= parse_json
    end

    def parse_json
        return nil unless body
        begin
            JSON.parse body
        rescue JSON::ParserError
            return nil
        end
    end
end