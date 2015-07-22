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
        @from = options.fetch(:from)
        @to = options.fetch(:to)
        @body = options.fetch(:body)
      end

      def create(conn, session)
        res = conn.post do |req|
          req.url URL
          req.body = {
            SessionID: eval(session),
            SourceAddress: @from,
            DestinationAddress: @to,
            Data: @body
          }
        end

        raise DevinoteleRest::RequestError, res.body unless res.success?
      end
    end
  end
end
