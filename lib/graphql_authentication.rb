require 'devise'
require 'graphql'
require 'graphql_authentication/configuration'
require 'graphql_authentication/engine'
require 'graphql_authentication/reset_password'
require 'graphql_authentication/jwt_manager'

module GraphQL
  module Authentication
    class << self
      attr_accessor :configuration
    end

    def self.configure
      @configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
