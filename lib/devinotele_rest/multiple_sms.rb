module DevinoteleRest
  class MultipleSms
    PATH = "/rest/Sms/SendBulk?"
    MAX_ASSDESSES_COUNT = 2999

    class << self
      def create(params, conn, session_id)
        resource = new(conn, session_id)
        resource.create(params)
      end

      private :new
    end

    def initialize(conn, session_id)
      @conn = conn
      @session_id = session_id
    end

    def create(from:, to:, body:)
      if !valid_addresses_count?(to)
        fail DevinoteleRest::CommonError.new("Too mach destination addresses in attribute: to")
      end

      params = {
        SessionID: @session_id,
        SourceAddress: from,
        DestinationAddresses: to,
        Data: body
      }
      res = @conn.post PATH, params

      return true if res.success?

      fail DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
    rescue Faraday::Error::TimeoutError => e
      fail DevinoteleRest::RequestError, e.message
    end

    private

    def valid_addresses_count?(to)
      addresses > MAX_ASSDESSES_COUNT
    end
  end
end
