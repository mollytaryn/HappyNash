require_relative '../test_helper'

class TestListingLocations < Minitest::Test

  def test_listing_no_locations
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a happy hour location
2. List all happy hour locations
3. Exit management menu
EOS
      pipe.puts "2"
      expected_output <<"No locations found. Add a location.\n"
      expected_output << <<EOS
1. Add a happy hour location
2. List all happy hour locations
3. Exit management menu
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_locations
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a happy hour location
2. List all happy hour locations
3. Exit management menu
EOS
      pipe.puts "2"
      expected_output = <<EOS
1. Wilhagan's
   314 Wilhagan Rd
   37217
   615-360-9175
   https://plus.google.com/116455568721224326104/about?gl=us&hl=en
   Wednesday 5:00 - 7:00
   $2 PBRs and $4 Margaritas
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
