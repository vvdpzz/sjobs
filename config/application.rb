require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Sjobs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{Rails.root}/app/models/enumerations)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
  class API < Grape::API
    prefix 'api'

    helpers do
      def warden
        env['warden']
      end

      def authenticated
        if warden.authenticated?
          return true
        elsif params[:access_token] and
          User.find_for_token_authentication("access_token" => params[:access_token])
          return true
        elsif params[:xapp_token] and
          AccessGrant.find_access(params[:xapp_token])
          return true
        else
          error!('401 Unauthorized', 401)
        end
      end

      def current_user
        warden.user || User.find_for_token_authentication("access_token" => params[:access_token])
      end

      # returns 401 if there's no current user
      def authenticated_user
        authenticated
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    resource 'questions' do

      get '/paid' do
        authenticated_user
        Question.paid
      end

      get '/free' do
        Question.free
      end

      get '/watch' do
      end
      
      get '/nearby' do
      end

      get '/:id' do
      end

      get '/:id/follow' do
      end

      get '/:id/favorite' do
      end

      post do
      end

      post '/:id/answers' do
      end

      get '/:id/vote_up' do
      end

      get '/:id/vote_down' do
      end

      post '/:id/comments' do
      end

      get '/:question_id/answers/:id/accept' do
      end
    end
    resource 'answers' do
      post '/:id/comments' do
      end

      get '/:id/vote_up' do
      end

      get '/:id/vote_down' do
      end
    end

    resource 'users' do
      get '/:id' do
      end

      get '/:id/follow' do
      end

      get '/:id/unfollow' do
      end
    end

    resource '/activity' do
    end

  end
end
