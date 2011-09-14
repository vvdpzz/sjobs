#usage:
#Start:
#     $ unicorn_rails -c config/unicorn.rb -E production -D
#Monitor:
#     $ pgrep -lf unicorn_rails
#Stop:
#     $ killall unicorn_rails
worker_processes 6
preload_app true
timeout 30
listen 3000

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end

stderr_path "#{Rails.root}/log/unicorn.log"
stdout_path "#{Rails.root}/log/unicorn.log"
