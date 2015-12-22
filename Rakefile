require 'rake'
require 'rspec/core/rake_task'

Bundler.require

require_all 'app', 'lib'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
