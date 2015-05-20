require_relative '../test_helper.rb'

describe LocationsController do

  describe ".index" do
    let(:controller) {LocationsController.new}

    it "should say no locations found when empty" do
      actual_output = controller.index
      expected_output = "No locations found. Add a location.\n"
      assert_equal expected_output, actual_output
    end
  end

  describe ".add" do
    let(:controller) {LocationsController.new}

    it "should add a location" do
      controller.add("Green House Bar")
      assert_equal 1, Location.count
    end

    it "should not add a location that is all spaces" do
      location_name = "      "
      result = controller.add(location_name)
      assert_equal "\"\" is not a valid location name.", result
    end

    it "should only add locations that makes sense" do
      location_name = "77777777"
      controller.add(location_name)
      assert_equal 0, Location.count
    end
  end

end
