#!/usr/bin/env Ruby
# -*- ruby -*-

require 'rake/clean'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new() do |config|
  config.pattern = "test/**/test_*.rb"
end
