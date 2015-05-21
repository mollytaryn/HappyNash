require_relative '../test_helper.rb'

class TestBasicUsage < Minitest::Test

  def test_manage_wrong_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen('./wise_old_dog blah') do |pipe|
      expected_output = "[Help] Run as: ./wise_old_dog manage"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_multiple_arguments_given
    shell_output = ""
    expected_output = ""
    IO.popen('./wise_old_dog manage blah') do |pipe|
      expected_output = "[Help] Run as: ./wise_old_dog manage"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_argument_given_then_exit
    shell_output = ""
    expected_output = ""
    IO.popen('./wise_old_dog manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "You have successfully exited the management menu.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
