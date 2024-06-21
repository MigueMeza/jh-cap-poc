# config/deploy.rb
set :application, "sample"
set :repository,  "path/to/your/repository"

set :scm, :git
set :branch, "main" # Cambia 'main' por la rama que desees desplegar
set :deploy_to, "/var/www/#{application}"
set :user, "deploy" # El usuario SSH para conectarse a la instancia EC2

role :web, "3.90.244.138"                          # Tu servidor HTTP
role :app, "3.90.244.138"                          # Este puede ser el mismo que tu servidor HTTP
role :db,  "3.90.244.138", :primary => true        # Tu servidor de base de datos, si aplica

# Configuraciones adicionales
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

