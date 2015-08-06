require 'faraday'
require "devinotele_rest/version"
require 'json'
require 'devinotele_rest/common_error'
require 'devinotele_rest/session'
require 'devinotele_rest/connection'
require 'devinotele_rest/sms'

module DevinoteleRest
  BASE_REST_URL = 'https://integrationapi.net'

  attr_reader :conn, :login, :password

  class Client
    def initialize(login, password)
      @login = login
      @password = password
      @conn = DevinoteleRest::Connection.create
    end

    def create(options)
      @session = get_session
      DevinoteleRest::Sms::Create.create(options, conn, @session.fetch(:token))
    end

    private
    def get_session
      @session_requester = DevinoteleRest::Session.new(@login, @password, @conn)
      if @session && @session_requester.valid_session?(@session)
        @session
      else
        @session_requester.get_session
      end
    end
  end
end
