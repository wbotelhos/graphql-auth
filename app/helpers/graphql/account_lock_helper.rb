module Graphql
  module AccountLockHelper

    def account_locked?(user)
      return false unless lockable?
      user.access_locked?
    end

    def lockable?
      GraphQL::Authentication.configuration.allow_lock_account
    end

  end
end
