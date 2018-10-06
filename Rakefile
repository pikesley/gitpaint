require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

require 'gitpaint'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :image do
  desc 'turn PNG into array of numbers'
  task :decompose, [:path] do |t, args|
    @pr = Gitpaint::PNGRenderer.new args[:path]
    puts @pr.inspect
  end
end
