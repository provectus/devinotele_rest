require 'pry-byebug'

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
      return res.body if res.success?

      raise DevinoteleRest::RequestError, res.body
    end
  end
end
