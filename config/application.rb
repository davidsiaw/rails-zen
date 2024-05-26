# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module RailsZen
  # The application config
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Clear hosts in Rails 6. No need to whitelist unless you
    # really want to.
    config.hosts.clear

    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app/apis/*')]
    config.active_job.queue_adapter = :sidekiq

    # Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new

    # Use a different logger for distributed setups.
    # require 'syslog/logger'
    # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new
    # 'app-name')
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    config.autoloader = :zeitwerk
  end
end
