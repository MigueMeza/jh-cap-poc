namespace :deploy do
  desc "Install dependencies"
  task :install do
    run "cd #{release_path} && bundle install --deployment"
  end
end

