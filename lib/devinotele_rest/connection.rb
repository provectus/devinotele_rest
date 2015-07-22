module DevinoteleRest
  module Connection
    extend self

    def create
      Faraday.new(url: DevinoteleRest::BASE_REST_URL) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
