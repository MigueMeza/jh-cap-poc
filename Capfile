load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/gems/*/recipes/*.rb', 'lib/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

