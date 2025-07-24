require 'rails_helper'

RSpec.describe "Authentication spec", type: :system do
  describe "login page" do
    it "displays login form" do
      visit login_path
      expect(page).to have_text("Login")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_button("Log in")
    end
  end

  describe "user login flow" do
    let(:user) { create_test_user }

    it "allows user to login with valid credentials" do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page).to have_text("Welcome to the hub")
      expect(current_path).to eq(hub_path)
    end

    it "shows error with invalid credentials" do
      visit login_path
      fill_in "Email", with: "wrong@email.com"
      fill_in "Password", with: "wrongpassword"
      click_button "Log in"

      expect(page).to have_text("Invalid email or password")
      expect(current_path).to eq(login_path)
    end
  end
end
