require 'minitest/autorun'
require_relative '../lib/crystallizer2'

class TestGets < Minitest::Test
  def setup; end

  def test_gets_to_i
    assert_equal Crystallizer.ruby2crystal("n = gets.to_i"), "n = read_line.to_i"
  end

  def test_gets_to_f
    assert_equal Crystallizer.ruby2crystal("n = gets.to_f"), "n = read_line.to_f"
  end

  def test_gets_chomp
    assert_equal Crystallizer.ruby2crystal("n = gets.chomp"), "n = read_line"
  end
end