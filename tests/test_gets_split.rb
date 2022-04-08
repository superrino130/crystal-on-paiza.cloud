require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestGets < Minitest::Test
  def setup; end

  def test_gets_split_map_to_i
    assert_equal Crystallizer.ruby2crystal("n = gets.split.map(&:to_i)"), "n = read_line.split.map(&.to_i)\n"
  end

  def test_gets_split_map_block_to_i
    assert_equal Crystallizer.ruby2crystal("n = gets.split.map{ |c| c.to_i }"), "n=read_line.split.map{ |c| c.to_i };"
  end
end