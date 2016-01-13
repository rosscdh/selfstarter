require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'byebug' if ['development', 'test'].include? Rails.env

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Selfstarter

  class Application < Rails::Application

    # --- Standard Rails Config ---
    config.time_zone = 'Europe/Berlin'
    config.i18n.default_locale = :'de'
    config.i18n.available_locales = ['en-GB', :de]
    config.encoding = "utf-8"
    config.filter_parameters += [:password]

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    # --- Standard Rails Config ---
  end
end