module GraphqlAuthentication
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_configuration
        template 'graphql_authentication.rb.erb', 'config/initializers/graphql_authentication.rb'
      end

      def rake_db
        rake("railties:install:migrations")
      end
    end
  end
end
