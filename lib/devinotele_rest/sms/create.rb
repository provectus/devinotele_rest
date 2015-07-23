module DevinoteleRest
  module Sms
    class Create
      URL = "/rest/Sms/Send?"

      class << self
        def create(options, conn, session)
          resource = new(options)
          resource.create(conn, session)
        end

        private :new
      end

      def initialize(options)
        @options = options
      end

      def create(conn, session)
        res = conn.post do |req|
          req.url URL
          req.body = {
            SessionID: session,
            SourceAddress: @options.fetch(:from),
            DestinationAddress: @options.fetch(:to),
            Data: @options.fetch(:body)
          }
        end

        return true if res.success?

        raise DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
      end
    end
  end
end
