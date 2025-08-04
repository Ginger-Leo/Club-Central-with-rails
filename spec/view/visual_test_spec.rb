# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'visual test spec', :js, type: :system do
  describe 'user login flow' do
    let(:user) { create_test_user }

    it 'shows the login process step by step' do
      visit login_path

      fill_in 'Email', with: user.email

      fill_in 'Password', with: 'password'

      click_button 'sign in'

      expect(page).to have_text('Welcome to the hub')
      expect(current_path).to eq(hub_path)
    end

    it 'opens Chrome and shows interactive behavior' do
      # puts 'Opening Chrome for test'
      # puts "Display: #{ENV['DISPLAY']}"
      # puts "Current driver: #{Capybara.current_driver}"

      # puts 'going to root adress.'
      visit root_path

      # puts 'Going to sign up page.'
      click_link 'sign up'

      # puts 'Filling in details.'
      fill_in 'Name', with: 'Test User'

      fill_in 'Email Address', with: 'test@example.com'

      fill_in 'Password', with: 'password123'

      fill_in 'Confirm Password', with: 'password123'

      click_button 'Create Account'
      # puts 'Test complete.'

      expect(page).to have_content('Login')
    end
  end

  describe 'finances flow' do
    let(:user) { create_test_admin }

    it 'shows the process to the finances dashboard' do
      visit login_path

      fill_in 'Email', with: user.email

      fill_in 'Password', with: 'password'

      click_button 'sign in'

      click_button 'club finances'

      expect(page).to have_text('Club Finances')
      expect(current_path).to eq(finances_path)
    end
  end

  describe 'event flow' do
    let(:user) { create_test_admin }

    before do
      Event.create!(
        event_type: 'training',
        datetime: 1.day.from_now,
        location: 'Test Location',
        notes: 'Test event'
      )
    end

    it 'Flow to add events' do
      visit login_path

      fill_in 'Email', with: user.email

      fill_in 'Password', with: 'password'

      click_button 'sign in'

      click_button 'add event'

      expect(page).to have_css('.modal-title', text: 'add event')
    end

    it 'Flow to edit events' do
      visit login_path

      fill_in 'Email', with: user.email

      fill_in 'Password', with: 'password'

      click_button 'sign in'

      click_button 'edit event'

      expect(page).to have_css('.modal-title', text: 'edit event')
    end
  end
end
