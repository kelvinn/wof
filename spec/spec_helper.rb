# spec/spec_helper.rb
ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara/poltergeist'


#require 'support/spec_test_helper'
require_relative File.join('..', 'app')

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL  
end

Capybara.configure do |config|
  config.default_driver = :poltergeist
  config.javascript_driver = :poltergeist
  config.run_server = false
  config.server_host = "localhost"
  config.server_port = 3000
  #config.default_driver = :selenium
  #config.app_host = "http://localhost:3000"
end

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,
                                      :phantomjs_options => ['--debug=no', '--load-images=no', '--ignore-ssl-errors=yes', '--ssl-protocol=TLSv1'], :debug => false)
  end