# frozen_string_literal: true

require 'spec_helper'
require 'capybara/rspec'

if ENV['CHROME_HOSTNAME'].present?
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   desired_capabilities: :chrome,
                                   url: "http://#{ENV['CHROME_HOSTNAME']}:4444/wd/hub")
  end
  Capybara.server_host = '0.0.0.0'
  Capybara.server_port = '4000'
  hostname = ENV['TEST_HOST'] || 'rails'
  Capybara.app_host = "http://#{hostname}:#{Capybara.server_port}"
else
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
end

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.javascript_driver = :chrome
  config.default_driver    = :rack_test
end

RSpec.configure do |config|
  config.include Capybara::DSL
end
