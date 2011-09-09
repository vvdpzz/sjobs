Hey guys, we are happy to announce that we updated Rails to 3.1 :)
=

## devise_invitable
    1.$ gem install devise_invitable

    2.# Gemfile
        gem 'devise'
        gem 'devise_invitable'

    3.$ bundle

    4.# Automatic installation
        rails generate devise_invitable:install
        rails generate devise_invitable User
      # Manual installation
      Detail: https://github.com/scambra/devise_invitable
  
    5.$ rake db:migrate

### 使 用 默 认 路 由 和 默 认 Devise::InvitationsController 中 的 四 种 action
Detail: https://raw.github.com/scambra/devise_invitable/master/app/controllers/devise/invitations_controller.rb
    6.# routes.rb
        devise_for :users

    7.$ rails generate devise_invitable:views

###(Optional:) 需 要 修 改 默 认 路 由 和 默 认 Devise::InvitationsController 中 的 action
    6.$ rails g controller Users::Invitations
        修 改 app/controllers/users/invitations_controller.rb 继 承 自 Devise::InvitationsController
        class Users::InvitationsController < Devise::InvitationsController
        end
    7.# routes.rb
        devise_for :users, :controllers => { :invitations => 'users/invitations' }
  
    8.$ rails generate devise_invitable:views users