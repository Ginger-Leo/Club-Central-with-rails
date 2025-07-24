# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'user control spec' do
    it 'creates a new user and redirects to login' do
      expect do
        post :create, params: {
          user: { username: 'newuser', email: 'new@example.com', password: 'password', position: 'Forward', location: 'City', balance: 0.0 }
        }
      end.to change(User, :count).by(1)
      expect(response).to redirect_to(login_path)
    end

    it 'sets a success flash message' do
      post :create, params: {
        user: { username: 'newuser', email: 'new@example.com', password: 'password', position: 'Forward', location: 'City', balance: 0.0 }
      }
      expect(flash[:notice]).to be_present
    end
  end
end
