require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

reporter_options = { color: true}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require "minitest/autorun"

class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM locations;")
  end
end


def create_location(name)
  Database.execute("INSERT INTO locations (name) VALUES (?)", name)
end

def main_menu
<<EOS
1. Add a happy hour location
2. List all happy hour locations
3. Exit management menu
EOS
end
