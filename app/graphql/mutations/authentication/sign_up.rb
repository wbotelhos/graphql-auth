# frozen_string_literal: true

class Mutations::Authentication::SignUp < GraphQL::Schema::Mutation
  include ::Graphql::TokenHelper

  argument :email, String, required: true do
    description "New user's email"
  end

  argument :password, String, required: true do
    description "New user's password"
  end

  argument :password_confirmation, String, required: true do
    description "New user's password confirmation"
  end

  field :errors, [::Types::Authentication::Error], null: false
  field :success, Boolean, null: false
  field :user, GraphQL::Authentication.configuration.user_type.constantize, null: true

  def resolve(args)
    response = context[:response]
    user = User.new args

    if user.save
      generate_access_token(user, response)

      {
        errors: [],
        success: true,
        user: user
      }
    else
      {
        errors: user.errors.messages.map do |field, messages|
          { field: field.to_s.camelize(:lower), message: messages.first.capitalize }
        end,
        success: false,
        user: nil
      }
    end
  end
end
