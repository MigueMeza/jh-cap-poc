#config/application.rb
require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # Si precompilas assets antes de desplegar a producción, usa esta línea
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # Si quieres compilar assets perezosamente en producción, usa esta línea
  # Bundler.require(:default, :assets, Rails.env)
end

module Sample
  class Application < Rails::Application
    # Configuración de la aplicación
    # Las configuraciones para el entorno/development/test deben estar en los
    # archivos correspondientes en config/environments
    # La configuración de la aplicación va aquí
  end
end
