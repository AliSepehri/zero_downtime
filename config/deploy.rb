# config/deploy.rb

set :application, 'zero_downtime'
set :repo_url, 'git@github.com:AliSepehri/zero_downtime.git'

namespace :deploy do
  after :published, 'docker:create_network'
  after :published, 'docker:start_nginx'
  after :published, 'docker:create_volumes'
  after :published, 'docker:db_setup'
  after :published, 'docker:start_container'
  after :published, 'docker:wait_for_container'
  after :published, 'docker:stop_container'
  after :published, 'docker:rename_container'
end
