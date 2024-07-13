# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mutations::Authentication::UnlockAccount, type: :request do
  let!(:admin_user) do
    User.create!(
      email: 'admin@example.com',
      password: 'password'
    )
  end

  let!(:user) do
    User.create!(
      email: 'email@example.com',
      password: 'password',
      locked_at: DateTime.now
    )
  end

  let(:result) do
    GraphqlSchema.execute(
      query_string,
      variables: variables,
      context: context
    )
  end

  let(:query_string) do
    <<-GRAPHQL
    mutation($id: ID!) {
      unlockAccount(id: $id) {
        success
        user {
          email
        }
        errors {
          field
          message
        }
      }
    }
    GRAPHQL
  end

  subject { result }

  context 'when the user is logged in' do
    let(:context) do
      {
        current_user: admin_user,
        response: ResponseMock.new(headers: {}),
      }
    end

    context 'when valid parameters are given' do
      let(:variables) do
        {
          'id' => user.id
        }
      end

      it 'succeeds to unlock the account' do
        subject

        expect(result['data']['unlockAccount']['success']).to be_truthy
      end
    end

    context 'when invalid parameters are given' do
      let(:variables) do
        {
          'id' => 0
        }
      end

      it 'fails to unlock the account' do
        subject
        expect(result['data']['unlockAccount']['success']).to be_falsey
      end
    end

    context 'when user is unlocked' do
      before do
        user.unlock_access!
      end

      let(:variables) do
        {
          'id' => user.id
        }
      end

      it 'fails to unlock the account' do
        subject
        expect(result['data']['unlockAccount']['success']).to be_falsey
      end
    end
  end

  context 'when the user not is logged in' do
    let(:context) do
      {
        current_user: nil,
        response: ResponseMock.new(headers: {}),
      }
    end

    context 'when valid parameters are given' do
      let(:variables) do
        {
          'id' => user.id
        }
      end

      it 'fails to unlock the account' do
        subject
        expect(result['data']['unlockAccount']['success']).to be_falsey
      end
    end

    context 'when invalid parameters are given' do
      let(:variables) do
        {
          'id' => 0
        }
      end

      it 'fails to unlock the account' do
        subject
        expect(result['data']['unlockAccount']['success']).to be_falsey
      end
    end

    context 'when user is unlocked' do
      before do
        user.unlock_access!
      end

      let(:variables) do
        {
          'id' => user.id
        }
      end

      it 'fails to unlock the account' do
        subject
        expect(result['data']['unlockAccount']['success']).to be_falsey
      end
    end
  end
end
