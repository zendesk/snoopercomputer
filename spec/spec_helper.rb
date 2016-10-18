require 'airborne'
require 'json'
require 'hashie'

def load_targets(targets = ENV.fetch('targets', 'targets'))
  load_json(targets)
rescue => e
  raise "Error loading targets info\n#{e.message}\nPlease add testing target info in spec/fixtures/targets and specify target in command line"
end

def load_json(filename = 'targets', path = './spec/fixtures/targets')
  absolute_path = File.expand_path(File.join(path, "#{filename}.json"))
  Hashie::Mash.new(JSON.parse(open(absolute_path).read))
end

def require_files(path)
  Dir[File.expand_path("#{path}/**/*.rb")].sort.each { |file| require file }
end

def current_targets
  @current_targets ||= load_targets(ENV['targets'])
end

def base_url
  current_targets.base_url
end

# Require all helper files
require_files './spec/support'

Airborne.configure do |config|
  config.base_url = current_targets.base_url
  config.extend FeatureHelper
end
