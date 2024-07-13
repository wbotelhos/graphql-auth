# frozen_string_literal: true

class Mutations::Authentication::ValidateToken < GraphQL::Schema::Mutation
  include ::Graphql::AccountLockHelper

  field :errors, [::Types::Authentication::Error], null: false
  field :success, Boolean, null: false
  field :user, GraphQL::Authentication.configuration.user_type.constantize, null: true
  field :valid, Boolean, null: false

  def resolve
    user = context[:current_user]

    if user.present? && !account_locked?(user)
      {
        errors: [],
        success: true,
        user: user,
        valid: true
      }
    else
      {
        errors: [],
        success: false,
        user: nil,
        valid: false
      }
    end
  end
end
