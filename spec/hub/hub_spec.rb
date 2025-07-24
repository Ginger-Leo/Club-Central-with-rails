# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hub spec', type: :system do
  describe 'when user is logged in' do
    it 'allows user to visit hub page' do
      user = create_test_user
      login_as(user)

      visit hub_path
      expect(page).to have_text('Welcome to the hub')
    end
  end

  describe 'when user is not logged in' do
    it 'redirects to login page' do
      visit hub_path
      expect(current_path).to eq(login_path)
    end
  end
end
