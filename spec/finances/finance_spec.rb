# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Finance, type: :model do
  describe 'finance spec' do
    it 'requires an amount' do
      finance = Finance.new
      expect(finance).not_to be_valid
      expect(finance.errors[:amount]).to include("can't be blank")
    end

    it 'requires a user' do
      finance = Finance.new(amount: 10.50)
      expect(finance).not_to be_valid
      expect(finance.errors[:user]).to include('must exist')
    end
  end

  describe 'creating a valid finance record' do
    let(:user) { create_test_user }

    it 'saves successfully with valid attributes' do
      finance = Finance.new(user: user, amount: 25.00, transaction_type: 'payment', notes: 'Test transaction')
      expect(finance).to be_valid
      expect(finance.save).to be true
    end
  end
end
