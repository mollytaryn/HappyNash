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
    Database.execute("DELETE FROM adages;")
  end
end


def create_adage(content)
  Database.execute("INSERT INTO adages (content) VALUES (?)", content)
end

def exit_from(pipe)
  pipe.puts "Exit"
  pipe.puts "3"
  main_menu + "You have successfully exited the management menu.\n"
end

def main_menu
<<EOS
1. Add an adage
2. List all adages
3. Exit management menu
EOS
end

def action_menu
<<EOS
1. Edit this adage
2. Delete this adage
3. Exit
EOS
end
