lock '~> 3.17.2'

set :pty, true
set :branch, :main
set :keep_releases, 5
set :application, 'titans'
set :deploy_to, '/home/ubuntu/titans'
set :ssh_options, verify_host_key: :never
set :repo_url, 'https://github.com/awaissajidror/titans.git'
set :linked_files, %w{config/database.yml config/application.yml}
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'tmp/webpacker', 'public/system', 'vendor', 'storage', 'public/uploads'
