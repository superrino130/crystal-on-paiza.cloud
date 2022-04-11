require 'minitest/autorun'
require_relative '../lib/crystallizer2'

class TestArray < Minitest::Test
  def setup; end

  def test_array_new
    assert_equal Crystallizer.ruby2crystal("a = Array.new(n, 0)"), "a = Array.new(n, 0)"
  end

  def test_array_gets_to_i
    assert_equal Crystallizer.ruby2crystal("a = Array.new(n){ gets.to_i }"), "a = Array.new(n){ read_line.to_i }"
  end
  
  def test_array_gets_split_to_i
    assert_equal Crystallizer.ruby2crystal("a = Array.new(n){ gets.split.map(&:to_i) }"), "a = Array.new(n){ read_line.split.map(&.to_i) }"
  end
end
