require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestGets < Minitest::Test
  def setup; end

  def test_gets_to_i
    assert_equal Crystallizer.ruby2crystal("n = gets.to_i"), "n = read_line.to_i\n"
  end

  def test_gets_to_f
    assert_equal Crystallizer.ruby2crystal("n = gets.to_f"), "n = read_line.to_f\n"
  end

  def test_gets_chomp
    assert_equal Crystallizer.ruby2crystal("n = gets.chomp"), "n = read_line\n"
  end
end