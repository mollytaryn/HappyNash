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
end
