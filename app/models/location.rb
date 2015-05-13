class Location
  attr_accessor :name

  def self.all
    Database.execute("select name from locations order by name ASC").map do |row|
      location = Location.new
      location.name = row[0]
      location
    end
  end

  def self.count
    Database.execute("select count(id) from locations")[0][0]
  end
end
