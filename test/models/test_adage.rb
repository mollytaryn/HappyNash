require_relative '../test_helper'

describe Adage do
  describe "#all" do
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

  describe ".initialize" do
    it "sets the content attribute" do
      adage = Adage.new("foo")
      assert_equal "foo", adage.content
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:adage){ Adage.new("Give a dog a bone.") }

      it "returns true" do
        assert adage.valid?
      end
    end

    describe "with no content" do
      let(:adage){ Adage.new(nil) }

      it "returns false" do
        refute adage.valid?
      end

      it "sets the error message" do
        adage.valid?
        assert_equal ["Content can't be blank."], adage.errors.full_messages
      end
    end

    describe "with empty content" do
      let(:adage){ Adage.new("") }

      it "returns false" do
        refute adage.valid?
      end

      it "sets the error message" do
        adage.valid?
        assert_equal ["Content can't be blank."], adage.errors.full_messages
      end
    end

    describe "with content with no letter characters" do
      let(:adage){ Adage.new("777") }

      it "returns false" do
        refute adage.valid?
      end

      it "sets the error message" do
        adage.valid?
        assert_equal ["Content must contain at least one letter."], adage.errors.full_messages
      end
    end

    describe "with previously invalid content" do
      let(:adage){ Adage.new("666") }

      before do
        refute adage.valid?
        adage.content = "Give a dog a bone."
        assert_equal "Give a dog a bone.", adage.content
      end

      it "should return true" do
        assert adage.valid?
      end
    end
  end

  describe "updating data" do

    describe "edit previously entered content" do
      let(:adage_content){ "Give a dog a bone." }
      let(:new_adage_content){ "Give a dog two bones." }

      it "should update adage content but not id" do
        adage = Adage.new(adage_content)
        adage.save
        assert_equal 1, Adage.count
        adage.content = new_adage_content
        assert adage.save
        assert_equal 1, Adage.count
        last_row = Database.execute("SELECT * FROM adages")[0]
        assert_equal new_adage_content, last_row['content']
      end

      it "shouldn't update other adages' content" do
        dog = Adage.new("Dog")
        dog.save
        adage = Adage.new(adage_content)
        adage.save
        assert_equal 2, Adage.count
        adage.content = new_adage_content
        assert adage.save
        assert_equal 2, Adage.count

        dog2 = Adage.find(dog.id)
        assert_equal dog.content, dog2.content
      end
    end

    describe "failed edit of previously entered adage" do
      let(:adage_content){ "Give a dog a bone." }
      let(:new_adage_content){ "" }
      it "does not update anything" do
        adage = Adage.new(adage_content)
        adage.save
        assert_equal 1, Adage.count
        adage.content = new_adage_content
        refute adage.save
        assert_equal 1, Adage.count
        last_row = Database.execute("SELECT * FROM adages")[0]
        assert_equal adage_content, last_row['content']
      end
    end
  end

  describe "#find_by_content" do
    describe "find when there's nothing in database" do
      before(:all) do
        adage = Adage.new("Give a dog a bone.")
        adage.save
      end

      it "should exist" do
        assert_respond_to Adage, :find_by_content
      end

      it "should return empty array" do
        results = Adage.find_by_content("yolo")
        assert_equal nil, results
      end

      it "should find only one item by a given name" do
        results = Adage.find_by_content("Give a dog a bone.")
        assert_equal "Give a dog a bone.", results.content
      end
    end
  end
end
