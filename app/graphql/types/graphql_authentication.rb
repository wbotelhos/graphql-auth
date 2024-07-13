# implements GraphQLAuthentication in in Types::MutationType to access authentication mutations

module Types::GraphqlAuthentication
  include GraphQL::Schema::Interface

  field :sign_in, mutation: ::Mutations::Authentication::SignIn

  if GraphQL::Authentication.configuration.allow_sign_up
    field :sign_up, mutation: GraphQL::Authentication.configuration.sign_up_mutation.constantize
  end

  field :forgot_password, mutation: ::Mutations::Authentication::ForgotPassword
  field :reset_password, mutation: ::Mutations::Authentication::ResetPassword

  field :update_account, mutation: GraphQL::Authentication.configuration.update_account_mutation.constantize

  field :validate_token, mutation: ::Mutations::Authentication::ValidateToken

  if GraphQL::Authentication.configuration.allow_lock_account
    field :lock_account, mutation: Mutations::Authentication::LockAccount
  end

  if GraphQL::Authentication.configuration.allow_unlock_account
    field :unlock_account, mutation: Mutations::Authentication::UnlockAccount
  end
end
