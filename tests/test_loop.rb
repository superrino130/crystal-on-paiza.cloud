require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestLoop < Minitest::Test
  def setup; end

  def test_each_one
    code =<<-EOF
    (0..n).each do |x|
      puts x
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "(0..n).each do |x|\nputs(x)\nend\n"
  end

  def test_each_with_index
    code =<<-EOF
    (0..n).each_with_index do |x, i|
      puts x + i
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "(0..n).each_with_index do |x, i|\nputs(x + i)\nend\n"
  end

  def test_times
    code =<<-EOF
    n.times do |i|
      puts i
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "(0..n).each_with_index do |x, i|\nputs(x + i)\nend\n"
  end
end
