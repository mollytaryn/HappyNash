require_relative '../test_helper.rb'

class AddingANewAdageTest < Minitest::Test

  def test_happy_path_adding_an_adage
    shell_output = ""
    expected_output = main_menu
    test_adage = "Give a dog a bone."
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      pipe.puts "1"
      expected_output << "If you are an old, wise dog, add your adage below:\n"
      pipe.puts test_adage
      expected_output << "\"#{test_adage}\" has been added!\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "1. #{test_adage}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_sad_path_adding_an_adage
    shell_output = ""
    happy_adage = "Give a dog a bone."
    expected_output = main_menu
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      pipe.puts "1"
      expected_output << "If you are an old, wise dog, add your adage below:\n"
      pipe.puts ""
      expected_output << "\"\" is not a real adage.\n"
      expected_output << "If you are an old, wise dog, add your adage below:\n"
      pipe.puts happy_adage
      expected_output << "\"#{happy_adage}\" has been added!\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "1. #{happy_adage}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

end
