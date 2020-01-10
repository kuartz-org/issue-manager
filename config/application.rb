require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KuartzIssueManager
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.javascripts false
      generate.channel assets: false
      generate.stylesheets false
      generate.test_framework false
    end

    config.i18n.default_locale = :fr
    config.i18n.fallbacks = [:en]
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
