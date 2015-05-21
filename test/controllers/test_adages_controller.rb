require_relative '../test_helper.rb'

describe AdagesController do

  describe ".index" do
    let(:controller) {AdagesController.new}

    it "should say no adages found when empty" do
      skip
      actual_output = controller.index
      expected_output = "No adages were found here. If you are an old, wise dog, add some adages.\n"
      assert_equal expected_output, actual_output
    end
  end

  describe ".add" do
    let(:controller) {AdagesController.new}

    it "should add a adage" do
      controller.add("Give a dog a bone.")
      assert_equal 1, Adage.count
    end

    it "should not add a adage that is all spaces" do
      adage_content = "      "
      result = controller.add(adage_content)
      assert_equal "\"\" is not a real adage.", result
    end

    it "should only add adages that makes sense" do
      adage_content = "77777777"
      controller.add(adage_content)
      assert_equal 0, Adage.count
    end
  end
end
