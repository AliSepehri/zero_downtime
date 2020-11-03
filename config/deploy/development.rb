# ./config/deploy/development.rb

set :stage, :development
set :branch, 'master'

set :deploy_to, '~/www/zero_downtime'

server 'localhost', roles: %w[web], primary: true
