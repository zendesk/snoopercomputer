require 'rubygems'
require 'rake'
require 'parallel_tests'
require 'parallel_tests/tasks'
require 'rspec'
require 'ci/reporter/rake/rspec'

Dir.glob('lib/tasks/*.rake').each { |r| load r }
Rake.add_rakelib 'lib/tasks/*'

task :default => :rspec

namespace :ci do
  namespace :setup do
    task :rspec_patched do
      setup_spec_opts('--format', "progress")
    end
  end

  task :all => ['ci:setup:rspec_patched', 'rspec']
end
