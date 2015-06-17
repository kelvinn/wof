require "./app"
require 'rspec/core/rake_task'
require "sinatra/activerecord/rake"

RSpec::Core::RakeTask.new :specs do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end