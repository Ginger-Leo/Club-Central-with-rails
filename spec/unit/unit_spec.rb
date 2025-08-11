# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires an email' do
      user = described_class.new(username: 'test', password: 'password')
      expect(user).not_to be_valid
    end

    it 'can create a valid user' do
      user = described_class.new(
        username: 'testuser',
        email: 'test@example.com',
        password: 'password',
        access_level: 'player'
      )
      expect(user).to be_valid
    end
  end
end

RSpec.describe Event, type: :model do
  describe 'validations' do
    it 'requires a datetime' do
      event = described_class.new(event_type: 'Training', location: 'Stadium')
      expect(event).not_to be_valid
    end

    it 'requires an event_type' do
      event = described_class.new(datetime: 1.day.from_now, location: 'Stadium')
      expect(event).not_to be_valid
    end
  end

  describe 'creating a valid event' do
    it 'saves successfully with valid attributes' do
      event = described_class.new(datetime: 1.day.from_now, event_type: 'Training', location: 'Stadium',
                                  notes: 'Bring boots')
      expect(event).to be_valid
    end
  end
end

RSpec.describe Finance, type: :model do
  describe 'validations' do
    it 'requires an amount' do
      finance = described_class.new
      expect(finance).not_to be_valid
    end

    it 'requires a user' do
      finance = described_class.new(amount: 10.50)
      expect(finance).not_to be_valid
    end
  end

  describe 'creating a valid finance record' do
    let(:user) { create_test_user }

    it 'saves successfully with valid attributes' do
      finance = described_class.new(user: user, amount: 25.00, transaction_type: 'payment', notes: 'Test transaction')
      expect(finance).to be_valid
    end
  end
end

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
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

RSpec.describe EventsController, type: :controller do
  describe 'POST #create' do
    context 'when user is a regular player' do
      let(:user) { create_test_user }

      before do
        login_as(user)
      end

      it 'redirects to hub path' do
        post :create, params: {
          event: { datetime: 1.day.from_now, event_type: 'Training', location: 'Stadium' }
        }
        expect(response).to redirect_to(hub_path)
      end

      it 'does not create the event' do
        expect do
          post :create, params: {
            event: { datetime: 1.day.from_now, event_type: 'Training', location: 'Stadium' }
          }
        end.not_to change(Event, :count)
      end
    end

    context 'when user is an admin' do
      let(:admin) { create_test_admin }

      before do
        login_as(admin)
      end

      it 'creates the event' do
        expect do
          post :create, params: {
            event: { datetime: 1.day.from_now, event_type: 'Training', location: 'Stadium' }
          }
        end.to change(Event, :count).by(1)
      end
    end
  end
end

RSpec.describe FinancesController, type: :controller do
  describe 'POST #add_payment' do
    let(:user) { create_test_user }

    before do
      login_as(user)
    end

    it 'processes payment and redirects to hub' do
      post :add_payment,
           params: { user_id: user.id, payee_id: user.id, amount: 10.50, notes: 'Test payment', redirect_to: hub_path }
      expect(response).to redirect_to(hub_path)
    end
  end
end

RSpec.describe HubController, type: :controller do
  describe 'GET #index' do
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

RSpec.describe 'Hub Authentication Flow', type: :request do
  describe 'user authentication flow' do
    let(:user) { create_test_user }

    it 'allows user to login and see welcome message' do
      post login_path, params: { email: user.email, password: 'password' }
      follow_redirect!
      expect(response.body).to include('Welcome to the hub')
    end

    it 'redirects unauthenticated user to login' do
      get hub_path
      expect(response).to redirect_to(login_path)
    end
  end
end
