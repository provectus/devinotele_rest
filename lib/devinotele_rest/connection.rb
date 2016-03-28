module DevinoteleRest
  class Connection
    def initialize
      @conn = Faraday.new(url: DevinoteleRest::BASE_REST_URL) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def get(path, params = {})
      @conn.get path, params
    end

    def post(path, params = {})
      @conn.post path, params
    end
  end
end
