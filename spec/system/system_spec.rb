# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication Flow', type: :system do
  let(:user) { create_test_user }

  describe 'login page' do
    it 'displays login form' do
      visit login_path
      expect(page).to have_text('Login')
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_button('sign in')
    end

    it 'allows user to login with valid credentials' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'sign in'
      expect(page).to have_text('Welcome to the hub')
    end

    it 'shows error with invalid credentials' do
      visit login_path
      fill_in 'Email', with: 'broken@email.com'
      fill_in 'Password', with: 'invalid'
      click_button 'sign in'
      expect(page).to have_text('Invalid email or password')
    end

    it 'shows the login process step by step' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'sign in'
      expect(page).to have_text('Welcome to the hub')
    end

    it 'allows user signup flow' do
      visit root_path
      click_link 'sign up'
      fill_in 'Name', with: 'Test User'
      fill_in 'Email Address', with: 'test@example.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Confirm Password', with: 'password123'
      click_button 'Create Account'
      expect(page).to have_content('Login')
    end
  end
end

RSpec.describe 'Hub Features', type: :system do
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

RSpec.describe 'Finances Flow', type: :system do
  describe 'admin access to finances' do
    let(:user) { create_test_admin }

    it 'shows the process to the finances dashboard' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'sign in'
      click_button 'club finances'
      expect(page).to have_text('Club Finances')
    end
  end
end

RSpec.describe 'Events Flow', type: :system do
  let(:user) { create_test_admin }

  before do
    Event.create!(
      event_type: 'training',
      datetime: 1.day.from_now,
      location: 'Test Location',
      notes: 'Test event'
    )
  end

  describe 'event management' do
    it 'allows admin to add events' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'sign in'
      click_button 'add event'
      expect(page).to have_css('.modal-title', text: 'add event')
    end

    it 'allows admin to edit events' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'sign in'
      find('button[aria-label="Edit event"]').click
      expect(page).to have_css('.modal-title', text: 'edit event')
    end
  end
end
