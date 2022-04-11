require 'minitest/autorun'
require_relative '../lib/crystallizer2'

class TestLoop < Minitest::Test
  def setup; end

  def test_each_one
    code =<<-EOF
    (0..n).each do |x|
      puts x
    end
    EOF
    code2 =<<-EOF
    (0..n).each do |x|
      puts x
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_each_with_index
    code =<<-EOF
    (0..n).each_with_index do |x, i|
      puts x + i
    end
    EOF
    code2 =<<-EOF
    (0..n).each_with_index do |x, i|
      puts x + i
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_times
    code =<<-EOF
    n.times do |i|
      puts i
    end
    EOF
    code2 =<<-EOF
    n.times do |i|
      puts i
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_upto
    code =<<-EOF
    0.upto(n) do |i|
      puts i
    end
    EOF
    code2 =<<-EOF
    0.upto(n) do |i|
      puts i
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_while
    code =<<-EOF
    x = 0
    while x < n
      puts x
      x += 1
    end
    EOF
    code2 =<<-EOF
    x = 0
    while x < n
      puts x
      x += 1
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end
end
