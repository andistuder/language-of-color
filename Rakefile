# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

task default: [:cucumber, :rubocop]

Rails.application.load_tasks

# begin
#   require 'rspec/core/rake_task'
#   RSpec::Core::RakeTask.new(:spec)
# rescue LoadError
#   desc 'Disabled as RSpec gem is unavailable'
#   task :spec do
#     warn 'Disabled as RSpec gem is unavailable'
#   end
# end
