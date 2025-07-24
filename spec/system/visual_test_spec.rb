require 'rails_helper'

RSpec.describe "visual test spec", type: :system, js: true do
  describe "user login flow" do
    let(:user) { create_test_user }

    it "shows the login process step by step" do
      visit login_path
      sleep 1

      fill_in "Email", with: user.email
      sleep 1

      fill_in "Password", with: "password"
      sleep 1

      click_button "sign in"
      sleep 2

      expect(page).to have_text("Welcome to the hub")
      expect(current_path).to eq(hub_path)

      sleep 2
    end
    it "opens Chrome and shows interactive behavior" do
        puts "Opening Chrome for test"
        puts "Display: #{ENV['DISPLAY']}"
        puts "Current driver: #{Capybara.current_driver}"

        puts "going to root adress."
        visit root_path
        sleep 2

        puts "Going to sign up page."
        click_link "sign up"
        sleep 3

        puts "Filling in details."
        fill_in "Name", with: "Test User"
        sleep 2

        fill_in "Email Address", with: "test@example.com"
        sleep 2

        fill_in "Password", with: "password123"
        sleep 2

        fill_in "Confirm Password", with: "password123"
        sleep 2

        click_link "Create Account"
        puts "Test complete."

         expect(page).to have_content("Login")
     end
  end

end
