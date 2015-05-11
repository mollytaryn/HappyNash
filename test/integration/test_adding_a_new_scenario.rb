require_relative '../test_helper.rb'

class AddingANewScenarioTest < Minitest::Test

  def test_gives_correct_argument
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash') do |pipe|
      expected_output = "[Help] Run as: ./happy_nash manage"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_argument_not_given
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash blah') do |pipe|
      expected_output = "[Help] Run as: ./happy_nash manage"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_argument_given_then_exit
    shell_output = ""
    expected_output = ""
    IO.popen('./happy_nash manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a happy hour location
2. List all happy hour locations
3. Exit management menu
EOS
      pipe.puts "3"
      expected_output << "You have successfully exited the management menu.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end


end
