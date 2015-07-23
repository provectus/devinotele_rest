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
      return res.body.slice(1..36) if res.success?

      raise DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
    end
  end
end
