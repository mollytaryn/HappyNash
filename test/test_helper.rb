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

def exit_from(pipe)
  pipe.puts "Exit"
  pipe.puts "3"
  main_menu + "You have successfully exited the management menu.\n"
end

def main_menu
<<EOS
1. Add a happy hour location
2. List all happy hour locations
3. Exit management menu
EOS
end

def action_menu
<<EOS
1. Edit this location
2. Delete this location
3. Exit
EOS
end
