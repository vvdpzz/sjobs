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

app_path = "/root/dev/sjobs"
stderr_path "#{app_path}/log/unicorn.log"
stdout_path "#{app_path}/log/unicorn.log"
