require_relative '../test_helper.rb'

class EditingANewLocationTest < Minitest::Test

  def test_user_left_location_unchanged
    shell_output = ""
    expected_output = main_menu
    test_location = "Green House Bar"
    Location.new(test_location).save
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "1. #{test_location}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << "What would you like to do?\n"
      expected_output << action_menu
      pipe.puts "3"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_happy_path_editing_a_location
    shell_output = ""
    expected_output = main_menu
    test_location = "Green House Bar"
    location = Location.new(test_location)
    location.save
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "1. #{test_location}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << "What would you like to do?\n"
      expected_output << action_menu
      pipe.puts "1"
      expected_output << "Please enter the updated information below:\n"
      pipe.puts "Blue House Bar"
      expected_output << "Your edit has been saved.\n"
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "You have successfully exited the management menu.\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
    new_name = Location.find(location.id).name
    assert_equal "Blue House Bar", new_name
  end

  def test_sad_path_editing_a_location
  shell_output = ""
  expected_output = main_menu
  test_location = "Green House Bar"
  location = Location.new(test_location)
  location.save
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "1. #{test_location}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << action_menu
      pipe.puts "1"
      expected_output << "Please enter the updated information below:\n"
      pipe.puts ""
      expected_output << "\"#{name}\" is not a valid location name.\n"
      expected_output << "Please enter the updated information below:\n"
      pipe.puts "Blue House Bar"
      expected_output << "Your edit has been saved.\n"
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "You have successfully exited the management menu.\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
  end

end
