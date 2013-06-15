require File.expand_path('../lib/chef/handler', __FILE__)

task :build do
  system 'gem build chef-handler-campfire.gemspec'
end

task :release do
  system "gem push chef-handler-campfire-#{Chef::Handler::Campfire::VERSION}.gem"
end

task :default => :build
