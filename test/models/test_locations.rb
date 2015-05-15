require_relative '../test_helper'

describe Location do
  describe "#all" do
    describe "if there are no locations in the database" do
      it "should return an empty array" do
        assert_equal [], Location.all
      end
    end
    describe "if there are locations" do
      before do
        create_location("Wilhagans")
        create_location("3 Crow Bar")
        create_location("Green House Bar")
      end
      it "should return the locations in alphabetical order" do
        expected = ["3 Crow Bar", "Green House Bar", "Wilhagans"]
        actual = Location.all.map(&:name)
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no locations in the database" do
      it "should return 0" do
        assert_equal 0, Location.count
      end
    end
    describe "if there are locations" do
      before do
        create_location("Wilhagans")
        create_location("3 Crow Bar")
        create_location("Green House Bar")
      end
      it "should return the correct count" do
        assert_equal 3, Location.count
      end
    end
  end

  describe ".initialize" do
    it "sets the name attribute" do
      location = Location.new("foo")
      assert_equal "foo", location.name
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:loc){ Location.new("3 Crow Bar") }
      it "should return true" do
        assert loc.save
      end
      it "should save the model to the database" do
        loc.save
        assert_equal 1, Location.count
        last_row = Database.execute("SELECT * FROM locations")[0]
        database_name = last_row['name']
        assert_equal "3 Crow Bar", loc.name
      end
      it "should populate the model with id from database" do
        loc.save
        last_row = Database.execute("SELECT * FROM locations")[0]
        database_id = last_row['id']
        assert_equal database_id, loc.id
      end
    end

    describe "if the model is invalid" do
      let(:loc){ Location.new("") }
      it "should return false" do
        refute loc.save
      end
      it "should not save the model to the database" do
        loc.save
        assert_equal 0, Location.count
      end
      it "should populate the error messages" do
        loc.save
        assert_equal "\"\" is not a valid location name.", loc.errors
      end
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:loc){ Location.new("3 Crow Bar") }
      it "returns true" do
        assert loc.valid?
      end
      it "should set errors to nil" do
        loc.valid?
        assert loc.errors.nil?
      end
    end
    describe "with no name" do
      let(:loc){ Location.new(nil) }
      it "returns false" do
        refute loc.valid?
      end
      it "sets the error message" do
        loc.valid?
        assert_equal "\"\" is not a valid location name.", loc.errors
      end
    end
    describe "with empty name" do
      let(:loc){ Location.new("") }
      it "returns false" do
        refute loc.valid?
      end
      it "sets the error message" do
        loc.valid?
        assert_equal "\"\" is not a valid location name.", loc.errors
      end
    end
    describe "with a name with no letter characters" do
      let(:loc){ Location.new("777") }
      it "returns false" do
        refute loc.valid?
      end
      it "sets the error message" do
        loc.valid?
        assert_equal "\"777\" is not a valid location name.", loc.errors
      end
    end
    describe "with a previously invalid name" do
      let(:loc){ Location.new("666") }
      before do
        refute loc.valid?
        loc.name = "3 Crow Bar"
        assert_equal "3 Crow Bar", loc.name
      end
      it "should return true" do
        assert loc.valid?
      end
      it "should not have an error message" do
        loc.valid?
        assert_nil loc.errors
      end
    end
  end
end
