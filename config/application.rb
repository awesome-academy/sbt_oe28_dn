require_relative "boot"

require "rails/all"

require "action_cable/engine"

Bundler.require(*Rails.groups)

module Project
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.
      join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:vi, :en]
    config.i18n.default_locale = :vi
    config.assets.initialize_on_precompile = false
    config.to_prepare do
    Devise::SessionsController.layout "users_sessions"
    Devise::RegistrationsController.layout "users_sessions"
    # Devise::ConfirmationsController.layout "your_layout_name"
    # Devise::UnlocksController.layout "your_layout_name"
    Devise::PasswordsController.layout "users_sessions"
    end
  end
end
