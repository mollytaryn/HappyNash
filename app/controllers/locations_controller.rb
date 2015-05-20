require 'highline/import'

class LocationsController

  def index
    if Location.count > 0
      locations = Location.all
      locations_string = ""
      locations.each_with_index do |location, index|
        locations_string << "#{index + 1}. #{location.name}\n"
      end
      locations_string
    else
      "No locations found. Add a location.\n"
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
end
