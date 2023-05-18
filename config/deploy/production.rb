set :rails_env, 'production'
server '18.196.228.67', user: 'ubuntu', roles: %w{web app db}
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
