require_relative '../test_helper'

describe Adage do
  describe "#all" do
    describe "if there are no adages in the database" do
      it "should return an empty array" do
        assert_equal [], Adage.all
      end
    end
    describe "if there are adages" do
      before do
        create_adage("Give a dog a bone.")
        create_adage("Give a dog two bones.")
        create_adage("Give a dog three bones.")
      end
      it "should return the adages in alphabetical order" do
        expected = ["Give a dog a bone.", "Give a dog three bones.", "Give a dog two bones."]
        actual = Adage.all.map(&:content)
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no adages in the database" do
      it "should return 0" do
        assert_equal 0, Adage.count
      end
    end
    describe "if there are adages" do
      before do
        create_adage("Give a dog a bone.")
        create_adage("Give a dog two bones.")
        create_adage("Give a dog three bones.")
      end
      it "should return the correct count" do
        assert_equal 3, Adage.count
      end
    end
  end

  describe ".initialize" do
    it "sets the content attribute" do
      adage = Adage.new("foo")
      assert_equal "foo", adage.content
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:adage){ Adage.new("Give a dog a bone.") }
      it "should return true" do
        assert adage.save
      end
      it "should save the model to the database" do
        adage.save
        assert_equal 1, Adage.count
        last_row = Database.execute("SELECT * FROM adages")[0]
        database_content = last_row['content']
        assert_equal "Give a dog a bone.", adage.content
      end
      it "should populate the model with id from database" do
        adage.save
        last_row = Database.execute("SELECT * FROM adages")[0]
        database_id = last_row['id']
        assert_equal database_id, adage.id
      end
    end

    describe "if the model is invalid" do
      let(:adage){ Adage.new("") }
      it "should return false" do
        refute adage.save
      end
      it "should not save the model to the database" do
        adage.save
        assert_equal 0, Adage.count
      end
      it "should populate the error messages" do
        adage.save
        assert_equal "\"\" is not a real adage.", adage.errors
      end
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:adage){ Adage.new("Give a dog a bone.") }
      it "returns true" do
        assert adage.valid?
      end
      it "should set errors to nil" do
        adage.valid?
        assert adage.errors.nil?
      end
    end
    describe "with no content" do
      let(:adage){ Adage.new(nil) }
      it "returns false" do
        refute adage.valid?
      end
      it "sets the error message" do
        adage.valid?
        assert_equal "\"\" is not a real adage.", adage.errors
      end
    end
    describe "with empty content" do
      let(:adage){ Adage.new("") }
      it "returns false" do
        refute adage.valid?
      end
      it "sets the error message" do
        adage.valid?
        assert_equal "\"\" is not a real adage.", adage.errors
      end
    end
    describe "with a content with no letter characters" do
      let(:adage){ Adage.new("777") }
      it "returns false" do
        refute adage.valid?
      end
      it "sets the error message" do
        adage.valid?
        assert_equal "\"777\" is not a real adage.", adage.errors
      end
    end
    describe "with a previously invalid content" do
      let(:adage){ Adage.new("666") }
      before do
        refute adage.valid?
        adage.content = "Give a dog a bone."
        assert_equal "Give a dog a bone.", adage.content
      end
      it "should return true" do
        assert adage.valid?
      end
      it "should not have an error message" do
        adage.valid?
        assert_nil adage.errors
      end
    end
  end
end
