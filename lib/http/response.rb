class HTTP::Response

    attr_accessor :success, :error, :body, :status, :type

    def initialize(params = {})
        params.each do |key, value|
            instance_variable_set("@#{key}", value)
        end
    end

    def json
        return nil unless body
        begin
            JSON.parse body
        rescue JSON::ParserError
            return nil
        end
    end
end