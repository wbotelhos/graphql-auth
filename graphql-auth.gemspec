$:.push File.expand_path('lib', __dir__)

require 'graphql-auth/version'

Gem::Specification.new do |spec|
  spec.name          = 'graphql-auth'
  spec.version       = GraphQL::Auth::VERSION
  spec.authors       = ['Guillaume Ferland', 'Brice Sanchez', 'Guillaume Loubier']
  spec.email         = ['ferland182@gmail.com']
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = %q{GraphQL + JWT + Devise}
  spec.description   = %q{GraphQL + JWT + Devise}
  spec.homepage      = 'https://github.com/o2web/graphql-auth'
  spec.license       = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md', 'CHANGELOG.md']

  spec.required_ruby_version = '>= 2.4.5'

  spec.add_dependency 'devise'
  spec.add_dependency 'graphql'
  spec.add_dependency 'jwt'
  spec.add_dependency 'rails'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
end
