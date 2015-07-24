module DevinoteleRest
  class Session
    URL = '/rest/user/sessionid?'
    SESSION_LIFE_IN_MINUTES = 120

    def initialize(login, password, conn)
      @login = login
      @password = password
      @conn = conn
    end

    def get_session
      res = @conn.get URL, { login: @login, password: @password }
      if res.success?
        { token: res.body.slice(1..36), created_at: Time.now }
      else
        raise DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
      end
    rescue Faraday::Error::TimeoutError => e
      raise DevinoteleRest::RequestError, e.message
    end

    def valid_session?(session)
      if session.is_a? Hash
        created_at = session.fetch(:created_at)
        (end_session_time(created_at) > Time.now) ? true : false
      else
        raise 'Session must be a hash'
      end
    end

    private
    def end_session_time(created_at)
      created_at + SESSION_LIFE_IN_MINUTES * 60
    end
  end
end
