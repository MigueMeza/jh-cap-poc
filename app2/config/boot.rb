# config/boot.rb

require 'rubygems'
require 'bundler/setup'

# Establecer el entorno RAILS_ENV
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])


