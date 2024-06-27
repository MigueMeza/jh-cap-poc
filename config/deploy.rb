# config/deploy.rb

# Nombre de la aplicación
set :application, "sample"

# Configuración del repositorio (none porque no estás usando un repositorio)
set :repository,  "."

# Configuración del sistema de control de versiones
set :scm, :none
set :deploy_via, :copy
set :copy_strategy, :export

# Directorio de despliegue en el servidor
set :deploy_to, "/home/centos/#{application}"

# Usuario para el despliegue
set :user, "root"

# Roles de los servidores
role :web, "3.87.242.222"
role :app, "3.87.242.222"
role :db,  "3.87.242.222", primary: true

# Opciones SSH
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false

# Tareas de despliegue
namespace :deploy do
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && export PATH='/opt/rubies/ruby-1.9.3-p551/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH' && bundle install"
  end

  task :prepare_tmp_dirs, :roles => :app do
    run "cd #{release_path} && sudo rm -rf tmp/pids && mkdir -p tmp/pids"
  end

  task :start, :roles => :app do
    run "cd #{current_path} && export PATH='/opt/rubies/ruby-1.9.3-p551/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH' && sudo rm -rf tmp/pids && mkdir -p tmp/pids && bundle exec rails server -d -b 0.0.0.0 -p 3000"
  end

  task :stop, :roles => :app do
    run "if [ -f #{current_path}/tmp/pids/server.pid ]; then kill -9 `cat #{current_path}/tmp/pids/server.pid`; fi"
  end

  task :restart, :roles => :app do
    deploy.stop
    deploy.start
  end

  task :clear_cache, :roles => :app do
    run "cd #{current_path} && bundle exec rake cache:clear"
  end

  task :precompile_assets, :roles => :app do
    run "cd #{release_path} && bundle exec rake assets:precompile"
  end

  before 'deploy:finalize_update', 'deploy:bundle_install'
  before 'deploy:finalize_update', 'deploy:prepare_tmp_dirs'
  before 'deploy:finalize_update', 'deploy:precompile_assets'
  after 'deploy:publishing', 'deploy:restart'
  after 'deploy:restart', 'deploy:clear_cache'
end

