# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TourConcierge
  class Application < Rails::Application # :nodoc:
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.active_record.default_timezone = :local
    config.time_zone = 'Tokyo'

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    I18n.enforce_available_locales = true
    config.i18n.available_locales = %i[ja en]
    config.i18n.default_locale = :ja

    # Don't generate system test files.
    config.generators do |g|
      g.template_engine   :slim
      g.stylesheet_engine :scss
      g.javascript_engine :coffee
      g.system_tests      nil
      g.test_framework    :rspec,
                          fixture: true,
                          fixture_replacement: :factory_bot,
                          view_specs: false,
                          routing_specs: false,
                          helper_specs: false,
                          integration_tool: false
    end
  end
end
