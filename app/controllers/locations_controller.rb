class LocationsController

  def index
    if Location.count > 0
      locations = Location.all
      locations.each_with_index do |location, index|
        say("#{index + 1}. #{location.name}")
      end
    else
      say("No locations found. Add a location.\n")
    end
  end
end
