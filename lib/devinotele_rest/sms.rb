module DevinoteleRest
  class Sms
    PATH = "/rest/Sms/Send?"

    class << self
      def create(params, conn, session_id)
        resource = new(conn, session_id)
        resource.create(params)
      end
    end

    def initialize(conn, session_id)
      @conn = conn
      @session_id = session_id
    end

    def create(from:, to:, body:)
      params = {
        SessionID: @session_id,
        SourceAddress: from,
        DestinationAddress: to,
        Data: body
      }
      res = @conn.post PATH, params

      return true if res.success?

      fail DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
    rescue Faraday::Error::TimeoutError => e
      fail DevinoteleRest::RequestError, e.message
    end
  end
end
