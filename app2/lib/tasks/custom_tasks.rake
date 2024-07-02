# lib/tasks/custom_tasks.rake

namespace :db do
  desc "Limpiar la base de datos"
  task :clean => :environment do
    puts "Limpiando la base de datos..."
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
    end
    puts "Base de datos limpia."
  end
end
