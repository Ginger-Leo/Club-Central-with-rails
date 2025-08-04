# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HubController, type: :controller do
  describe 'hub controller spec' do
    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end

    context 'when user is logged in' do
      let(:user) { create_test_user }

      before do
        login_as(user)
      end

      it 'returns success response' do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
