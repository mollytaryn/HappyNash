require_relative '../test_helper.rb'

class AddingANewLocationTest < Minitest::Test

  def test_manage_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "1"
      expected_output << "What is the name of the location you want to add?\n"
      pipe.puts "Wilhagan's"
      expected_output << "What is the street address of this location?\n"
      pipe.puts "314 Wilhagan Rd"
      expected_output <<"Thank you for adding a new location to the HappyNash database!\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
