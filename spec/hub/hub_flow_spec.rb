# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hub Flow', type: :request do
  describe 'user authentication flow' do
    let(:user) { create_test_user }

    it 'allows user to login and see welcome message' do
      post login_path, params: { email: user.email, password: 'password' }
      expect(response).to redirect_to(hub_path)
      follow_redirect!
      expect(response.body).to include('Welcome to the hub')
    end

    it 'redirects unauthenticated user to login' do
      get hub_path
      expect(response).to redirect_to(login_path)
    end
  end
end
