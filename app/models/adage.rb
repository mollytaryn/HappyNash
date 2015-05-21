class Adage
  attr_reader :id, :errors
  attr_accessor :content

  def initialize(content = nil)
    self.content = content
  end

  def ==(other)
    other.is_a?(Adage) && other.id == self.id
  end

  def self.all
    Database.execute("select * from adages order by content ASC").map do |row|
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from adages")[0][0]
  end

  def self.find(id)
    row = Database.execute("select * from adages where id = ?", id).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.find_by_content(content)
    row = Database.execute("select * from adages where content LIKE ?", content).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.destroy(id)
    Database.execute("DELETE FROM adages WHERE id=?", id)
    @id = nil
  end

  def valid?
    if content.nil? or content.empty? or /^\d+$/.match(content)
      @errors = "\"#{content}\" is not a real adage."
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    if @id.nil?
      Database.execute("INSERT INTO adages (content) VALUES (?)", content)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    else
      Database.execute("UPDATE adages SET content=? WHERE id=?", content, id)
      true
    end
  end

  private

  def self.populate_from_database(row)
    adage = Adage.new
    adage.content = row['content']
    adage.instance_variable_set(:@id, row['id'])
    adage
  end
end
