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

  # def test_gets_split_map_to_i2
  #   assert_equal Crystallizer.ruby2crystal("h, w = gets.split.map(&:to_i)"), "h,w=read_line.split.map(&.to_i);"
  # end

  # def test_gets_split_map_to_f
  #   assert_equal Crystallizer.ruby2crystal("n = gets.split.map(&:to_f)"), "n=read_line.split.map(&.to_f);"
  # end

  # def test_gets_split_chars
  #   assert_equal Crystallizer.ruby2crystal("n = gets.split.chars"), "n=read_line.split.chars;"
  # end
end