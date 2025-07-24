module SessionsHelper
  def create_test_user(access_level: "player", email: nil, password: "password", username: nil)
    User.create!(
      username: username || "testuser_#{rand(1000)}",
      email: email || "test_#{rand(1000)}@example.com",
      password: password,
      access_level: access_level,
      position: "Forward",
      location: "City",
      balance: 0.0
    )
  end

  def create_test_admin
    create_test_user(access_level: "admin", username: "testadmin_#{rand(1000)}")
  end

  def login_as(user)
    if respond_to?(:visit)
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_button "Log in"
    else
      session[:user_id] = user.id
    end
  end
end
