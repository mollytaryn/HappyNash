require_relative '../test_helper'

class TestListingAdages < Minitest::Test

  def test_listing_no_adages
    shell_output = ""
    expected_output = ""
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output <<"No adages were found here. If you are an old, wise dog, add some adages.\n"
      expected_output << main_menu
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_adages
    create_adage("Give a dog a bone.")
    create_adage("Give a dog two bones.")
    shell_output = ""
    expected_output = ""
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << <<EOS
1. Give a dog a bone.
2. Give a dog two bones.
3. Exit
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
