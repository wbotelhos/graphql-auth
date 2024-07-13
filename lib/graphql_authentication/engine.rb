module GraphQL
  module Authentication
    class Engine < ::Rails::Engine
      isolate_namespace GraphQL::Authentication

      config.autoload_paths += Dir["#{config.root}/app/**/*.rb"]
    end
  end
end
