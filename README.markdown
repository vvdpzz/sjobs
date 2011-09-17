Hey guys, we are happy to announce that we updated Rails to 3.1 :)
=

### AND, Ruby 1.9.2 p290 is ready!

```
bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile

source ~/.bash_profile

rvm install 1.9.2-p290

rvm use 1.9.2 --default

sudo gem install rails

bundle

sudo install_name_tool -change libmysqlclient.18.dylib /usr/local/mysql/lib/libmysqlclient.18.dylib ~/.rvm/gems/ruby-1.9.2-p290/gems/mysql2-0.3.7/lib/mysql2/mysql2.bundle
```

## How to start app

###Step 0 (Optional)
	bundle
###Step 1 start Redis
	sudo redis-server /usr/local/etc/redis.conf
###Step 2 start Mongodb
	sudo mongod run --config /usr/local/Cellar/mongodb/1.8.3-x86_64/mongod.conf
###Step 3 start MySQL
	...
###Step 4 start resque
	QUEUE=* rake resque:work
###Step 5 start resque web
	resque-web
###Step 6 start WEBrick
	rails s

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

### 使用默认路由和默认 Devise::InvitationsController 中 的 四 种 action
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