require_relative '../test_helper.rb'

class EditingANewAdageTest < Minitest::Test

  def test_user_left_adage_unchanged
    shell_output = ""
    expected_output = main_menu
    test_adage = "Give a dog a bone."
    Adage.new(test_adage).save
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "1. #{test_adage}\n"
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

  def test_happy_path_editing_a_adage
    shell_output = ""
    expected_output = main_menu
    test_adage = "Give a dog a bone."
    adage = Adage.new(test_adage)
    adage.save
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "1. #{test_adage}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << "What would you like to do?\n"
      expected_output << action_menu
      pipe.puts "1"
      expected_output << "Please enter the updated adage below:\n"
      pipe.puts "Give a dog two bones."
      expected_output << "Your edit has been saved.\n"
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "You have successfully exited the management menu.\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
    new_content = Adage.find(adage.id).content
    assert_equal "Give a dog two bones.", new_content
  end

  def test_sad_path_editing_an_adage
  shell_output = ""
  expected_output = main_menu
  test_adage = "Give a dog a bone."
  adage = Adage.new(test_adage)
  adage.save
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      pipe.puts "2"
      expected_output << "1. #{test_adage}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << action_menu
      pipe.puts "1"
      expected_output << "Please enter the updated adage below:\n"
      pipe.puts ""
      expected_output << "\"\"  is not a real adage.\n"
      expected_output << "Please enter the updated adage below:\n"
      pipe.puts "Give a dog two bones."
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
