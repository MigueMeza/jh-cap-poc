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
set :deploy_to, "/var/www/#{application}"

# Usuario para el despliegue
set :user, "deploy"

# Roles de los servidores
role :web, "2.4.6.8"
role :app, "2.4.6.8"
role :db,  "2.4.6.8", primary: true

# Opciones SSH
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false

# Tareas de despliegue
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

