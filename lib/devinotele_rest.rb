require 'faraday'
require 'json'

require "devinotele_rest/version"

module DevinoteleRest
  BASE_REST_URL = 'https://integrationapi.net'

  autoload :CommonError, "devinotele_rest/errors"
  autoload :RequestError, "devinotele_rest/errors"

  autoload :Connection, "devinotele_rest/connection"
  autoload :Session, "devinotele_rest/session"

  autoload :Sms, "devinotele_rest/sms"
  autoload :MultipleSms, "devinotele_rest/multiple_sms"
  autoload :Client, "devinotele_rest/client"
end
