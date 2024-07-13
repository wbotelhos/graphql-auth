# frozen_string_literal: true

class Mutations::Authentication::UpdateAccount < GraphQL::Schema::Mutation
  argument :current_password, String, required: true do
    description "User's current password"
  end

  argument :password, String, required: true do
    description "User's new password"
  end

  argument :password_confirmation, String, required: true do
    description "User's new password confirmation"
  end

  field :errors, [::Types::Authentication::Error], null: false
  field :success, Boolean, null: false
  field :user, GraphQL::Authentication.configuration.user_type.constantize, null: true

  def resolve(args)
    user = context[:current_user]

    if user.blank?
      return {
        errors: [
          { field: :_error, message: I18n.t('devise.failure.unauthenticationenticated') }
        ],
        success: false,
        user: nil
      }
    end

    user.update_with_password args

    if user.errors.any?
      {
        errors: user.errors.messages.map do |field, messages|
          { field: field.to_s.camelize(:lower), message: messages.first.capitalize }
        end,
        success: false,
        user: nil
      }
    else
      {
        errors: [],
        success: true,
        user: user
      }
    end
  end
end
