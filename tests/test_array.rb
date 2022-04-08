require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestArray < Minitest::Test
  def setup; end

  def test_array_new
    code =<<-EOF
    a = Array.new(n, 0)
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "a = Array(Int32).new(n, 0)\n"
  end

  def test_array_gets_to_i
    code =<<-EOF
    a = Array.new(n){ gets.to_i }
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "a = Array(Int32).new(n){ read_line.to_i }\n"
  end
  
  def test_array_gets_split_to_i
    code =<<-EOF
    a = Array.new(n){ gets.split.map(&:to_i) }
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "a = Array(Array(Int32)).new(n){ read_line.split.map(&.to_i) }\n"
  end
end
