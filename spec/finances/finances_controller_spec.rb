# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FinancesController, type: :controller do
  describe 'finances contoller spec' do
    let(:user) { create_test_user }

    before do
      login_as(user)
    end

    it 'processes payment and redirects to hub' do
      post :add_payment,
           params: { user_id: user.id, payee_id: user.id, amount: 10.50, notes: 'Test payment', redirect_to: hub_path }
      expect(response).to redirect_to(hub_path)
    end

    it 'creates finance records for both payer and payee' do
      expect do
        post :add_payment,
             params: { user_id: user.id, payee_id: user.id, amount: 10.50, notes: 'Test payment',
                       redirect_to: hub_path }
      end.to change(Finance, :count).by(2)
    end
  end
end
