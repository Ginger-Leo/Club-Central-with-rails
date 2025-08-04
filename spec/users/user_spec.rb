# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user spec' do
    it 'requires an email' do
      user = described_class.new(username: 'test', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
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
