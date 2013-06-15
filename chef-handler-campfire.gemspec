require File.expand_path('../lib/chef/handler', __FILE__)

Gem::Specification.new do |s|
  s.name = 'chef-handler-campfire'
  s.version = Chef::Handler::Campfire::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Brian Scott', 'Greg Albrecht', 'Matt Reiferson']
  s.email = ['brainscott@gmail.com', 'gba@splunk.com', 'mreiferson@gmail.com']
  s.homepage = 'https://github.com/simplereach/chef-handler-campfire'
  s.summary = 'Chef Exception & Reporting Handler for Campfire'
  s.description = 'A Chef handler adding the ability to deliver exceptions and reports to Campfire'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_runtime_dependency('broach')
end
