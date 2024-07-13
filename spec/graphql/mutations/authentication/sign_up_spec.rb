# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mutations::Authentication::SignUp, type: :request do
  let(:result) do
    GraphqlSchema.execute(
      query_string,
      variables: variables,
      context: context
    )
  end

  let(:query_string) do
    <<-GRAPHQL
    mutation($email: String!, $password: String!, $passwordConfirmation: String!) {
      signUp(email: $email, password: $password, passwordConfirmation: $passwordConfirmation) {
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

  let(:context) do
    {
      current_user: nil,
      response: ResponseMock.new(headers: {}),
    }
  end

  subject { result }

  context 'when valid parameters are given' do
    let(:variables) do
      {
        'email' => 'email@example.com',
        'password' => 'password',
        'passwordConfirmation' => 'password'
      }
    end

    it 'sign up the user' do
      subject
      expect(result['data']['signUp']['success']).to be_truthy
    end
  end

  context 'when invalid parameters are given' do
    let(:variables) do
      {
        'email' => 'emailexample.com',
        'password' => 'password',
        'passwordConfirmation' => 'password2'
      }
    end

    it 'fails to sign up the user' do
      subject
      expect(result['data']['signUp']['success']).to be_falsey
    end
  end
end
