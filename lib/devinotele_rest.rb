require 'faraday'
require "devinotele_rest/version"
require 'json'
require 'devinotele_rest/common_error'
require 'devinotele_rest/session'
require 'devinotele_rest/connection'
require 'devinotele_rest/sms'

module DevinoteleRest
  BASE_REST_URL = 'https://integrationapi.net'

  class Client
    def initialize(login, password)
      @conn = DevinoteleRest::Connection.create
      @session_r = DevinoteleRest::Session.new(login, password, @conn)
    end

    def create(options)
      session = @session_r.get_session
      DevinoteleRest::Sms::Create.create(options, @conn, session)
    end
  end
end
