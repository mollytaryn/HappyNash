require 'sqlite3'
require 'active_record'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS adages (
      id integer PRIMARY KEY AUTOINCREMENT,
      content varchar(600) NOT NULL
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = Environment.current
    database = "db/wise_old_dog_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
    @@db.results_as_hash = true
  end
end
