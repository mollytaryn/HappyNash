require 'highline/import'

class LocationsController

  def index
    if Location.count > 0
      locations = Location.all
      choose do |menu|
        menu.prompt = ""
        locations.each do |location|
          menu.choice(location.name) { action_menu(location) }
        end
        menu.choice("Exit")
      end
    else
      say("No locations found. Add a location.\n")
    end
  end

  def action_menu(location)
    say("What would you like to do?")
    choose do |menu|
      menu.prompt = ""
      menu.choice("Edit this location") do
        edit(location)
      end
      menu.choice("Delete this location") do
        destroy(location)
      end
      menu.choice("Exit") do
        exit
      end
    end
  end

  def add(name)
    name_cleaned = name.strip
    location = Location.new(name_cleaned)
    if location.save
      "\"#{name}\" has been added!\n"
    else
      location.errors
    end
  end

  def edit(location)
    loop do
      user_input = ask("Please enter the updated information below:")
      location.name = user_input.strip
      if location.save
        say("Your edit has been saved.")
        return
      else
        say(location.errors)
      end
    end
  end
end
