require 'devise'
require 'graphql'
require 'graphql_auth/configuration'
require 'graphql_auth/engine'
require 'graphql_auth/reset_password'
require 'graphql_auth/jwt_manager'

module GraphQL
  module Auth
    class << self
      attr_accessor :configuration
    end

    def self.configure
      @configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
