require 'spec_helper'
require 'capybara/rspec'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'selenium-webdriver'

ENV['RAILS_ENV'] ||= 'test'
abort("The Rails environment is running in production mode!") if Rails.env.production?

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include SessionsHelper

  config.before(:each) do
    User.destroy_all
    Event.destroy_all
    Finance.destroy_all
  end
end


Selenium::WebDriver::Chrome::Service.driver_path = '/usr/bin/chromedriver'

Capybara.register_driver :selenium_chrome_visible do |app|
  service = Selenium::WebDriver::Chrome::Service.new(path: '/usr/bin/chromedriver')
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--start-maximized')
  options.add_argument('--disable-background-timer-throttling')
  options.add_argument('--disable-renderer-backgrounding')
  options.add_argument('--new-window')
  options.add_argument('--force-device-scale-factor=1')

  Capybara::Selenium::Driver.new(app, browser: :chrome, service: service, options: options)
end

Capybara.default_driver = :selenium_chrome_visible
Capybara.javascript_driver = :selenium_chrome_visible

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_visible
  end
end

Capybara.default_driver = :selenium_chrome_visible
Capybara.javascript_driver = :selenium_chrome_visible

Capybara.server_host = '127.0.0.1'
Capybara.server_port = 3001

Capybara.default_max_wait_time = 15
