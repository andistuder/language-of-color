begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  desc 'Disabled as RuboCop gem is unavailable'
  task :rubocop do
    raise 'Disabled as RuboCop gem is unavailable'
  end
end
