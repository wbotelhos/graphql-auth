module GraphQL
  module Authentication
    class ResetPassword
      class << self
        def url(token)
          url = I18n.locale === :fr ? 'nouveau-mot-de-passe' : 'new-password'
          "#{GraphQL::Authentication.configuration.app_url}/#{I18n.locale}/#{url}/#{token}"
        end
      end
    end
  end
end
