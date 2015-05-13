require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS locations (
      id integer PRIMARY KEY AUTOINCREMENT,
      name varchar(160) NOT NULL
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/happy_nash_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
  end
end
