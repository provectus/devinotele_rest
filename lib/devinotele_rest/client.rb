module DevinoteleRest
  class Client
    def initialize(login, password)
      @login = login
      @password = password
    end

    def create(from:, to:, body:)
      case to
      when String, Numeric
        send from: from, to: to, body: body
      when Array
        multiple_send from: from, to: to, body: body
      else
        fail DevinoteleRest::CommonError.new("Unknown argument format: to")
      end
    end

    private

    def send(params)
      DevinoteleRest::Sms.create(params, connection, session.session_id))
    end

    def multiple_send(params)
      DevinoteleRest::MultipleSms.create(params, connection, session.session_id)
    end


    def connection
      @conn ||= DevinoteleRest::Connection.new
    end

    def session
      @session ||= DevinoteleRest::Session.new(@login, @password, connection)
      if @session.expired?
        @session = DevinoteleRest::Session.new(@login, @password, connection)
      end
      @session
    end
  end
end
