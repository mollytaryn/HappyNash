require_relative '../test_helper'

class TestListingLocations < Minitest::Test

  def test_listing_no_locations
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output <<"No locations found. Add a location.\n"
      expected_output << main_menu
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_locations
    create_location("Wilhagan's")
    create_location("3 Crow Bar")
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << <<EOS
1. 3 Crow Bar
2. Wilhagan's
3. Exit
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
