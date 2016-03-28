module DevinoteleRest
  class Session
    PATH = '/rest/user/sessionid?'
    SESSION_LIFE_IN_MINUTES = 120 * 60

    attr_reader :session_id

    def initialize(login, password, conn)
      @login = login
      @password = password
      @conn = conn
      create
    end

    def expired?
      uptime > SESSION_LIFE_IN_MINUTES
    end

    private

    def create
      res = @conn.get PATH, { login: @login, password: @password }
      if res.success?
        @session_id = res.body.slice(1..36)
        @created_at = Time.now
      else
        fail DevinoteleRest::RequestError, JSON.parse(res.body)['Desc']
      end
    rescue Faraday::Error::TimeoutError => e
      fail DevinoteleRest::RequestError, e.message
    end

    def uptime
      (Time.now - @created_at).to_i
    end
  end
end
