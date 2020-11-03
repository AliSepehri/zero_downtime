# ./lib/capistrano/tasks/docker.rake

namespace :docker do
  desc 'Create required network'
  task :create_network do
    on roles(:web) do
      execute :docker, 'network', 'create', 'backend', '|| echo "Network already exists!"'
    end
  end

  desc 'Create required volumes'
  task :create_volumes do
    on roles(:web) do
      execute :docker, 'volume', 'create', "app_log"
    end
  end

  desc 'Setup database'
  task :db_setup do
    on roles(:web) do
      within shared_path do
        execute(
          :docker,
          'run',
          '--rm',
          '--entrypoint bundle',
          '--network=backend',
          'zero-downtime',
          'exec rails db:setup'
        )
      end
    end
  end

  desc 'Start a new container'
  task :start_container do
    on roles(:web) do
      within shared_path do
        execute :docker, 'stop zero-downtime-app', '|| echo "Container is not running!"'
        execute :docker, 'rm zero-downtime-app', '|| echo "Container does not exist!"'
        execute(
          :docker,
          'create',
          '--name zero-downtime-app',
          '--volume app_log:/var/www/app/log',
          '--publish 3000:3000',
          '--network=backend',
          'zero-downtime'
        )
        execute :docker, 'start', 'zero-downtime-app'
      end
    end
  end
end
