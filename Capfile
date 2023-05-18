require 'capistrano/setup'

require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/puma'
require 'capistrano/rbenv'
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/passenger'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
