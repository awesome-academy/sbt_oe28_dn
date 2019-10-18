require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Project1
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.
      join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
  end
end
