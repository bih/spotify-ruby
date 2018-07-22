# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "yard"

# RSpec
# For testing the Spotify Ruby project.
RSpec::Core::RakeTask.new(:spec)

# Rubocop
# Making sure our code is linted.
RuboCop::RakeTask.new

# YARD
# Making all of the code documentable.
YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb"]
end

task default: :spec
task ci: %i[spec rubocop]
