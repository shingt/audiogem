#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

task :default => :test
task :test => [:base_test]

Rake::TestTask.new(:base_test) do |t|
  t.libs << "test"
  t.test_files = Dir["test/**/test_*.rb"].sort
  t.verbose = true
end

