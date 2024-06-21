namespace :deploy do
  desc 'Install application dependencies'
  task :install do
    on roles(:app) do
      within release_path do
        execute :bundle, 'install --deployment'
        execute :yarn, 'install'
      end
    end
  end
end
