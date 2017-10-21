# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "coveralls/rake/task"
require "rdoc/task"

# RSpec
# For testing the Spotify Ruby project.
RSpec::Core::RakeTask.new(:spec)

# Coveralls
# Making sure we have complete code coverage.
Coveralls::RakeTask.new
task test_with_coveralls: [:spec, :features, "coveralls:push"]

# Rubocop
# Making sure our code is linted.
RuboCop::RakeTask.new

# RDoc
# Making all of the code documentable.
RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_files.include("README.md", "lib   /*.rb")
end

task default: :spec
task ci: [:spec, "coveralls:push", :rubocop]
