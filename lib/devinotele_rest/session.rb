module DevinoteleRest
  class Session
    URL = '/rest/user/sessionid?'

    def initialize(login, password, conn)
      @login = login
      @password = password
      @conn = conn
    end

    def get_session
      res = @conn.get URL, { login: @login, password: @password }
      if res.success?
        res.body.slice(1..36)
      else
        raise DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
      end
    rescue Faraday::Error::TimeoutError => e
      raise DevinoteleRest::RequestError, e.message
    end
  end
end
