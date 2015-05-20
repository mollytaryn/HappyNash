require_relative '../test_helper.rb'

class AddingANewLocationTest < Minitest::Test

  def test_happy_path_adding_a_location
    shell_output = ""
    expected_output = main_menu
    test_location = "House Bar"
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      pipe.puts "1"
      expected_output << "What is the name of the location you want to add?\n"
      pipe.puts test_location
      expected_output << "\"#{test_location}\" has been added!\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "1. #{test_location}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_sad_path_adding_a_location
    shell_output = ""
    happy_location = "House Bar"
    expected_output = main_menu
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      pipe.puts "1"
      expected_output << "What is the name of the location you want to add?\n"
      pipe.puts ""
      expected_output << "\"\" is not a valid location name.\n"
      expected_output << "What is the name of the location you want to add?\n"
      pipe.puts happy_location
      expected_output << "\"#{happy_location}\" has been added!\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "1. #{happy_location}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

end
