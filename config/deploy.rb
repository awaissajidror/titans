# capistrano version
lock '3.17.2'

set :application, 'titans'
set :repo_url, 'https://github.com/awaissajidror/titans.git'
set :branch, :main
set :deploy_to, '/home/ubuntu/titans'
set :pty, true

# if rails 5.2 & above master.key is used instead of application.yml
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 3
set :ssh_options, verify_host_key: :never