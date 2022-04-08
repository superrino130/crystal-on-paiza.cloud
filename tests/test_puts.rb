require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestPuts < Minitest::Test
  def setup; end

  def test_puts_integer
    assert_equal Crystallizer.ruby2crystal("puts n"), "puts((n))\n"
  end

  def test_puts_integer_add
    assert_equal Crystallizer.ruby2crystal("puts a + b"), "puts(a + b)\n"
  end

  def test_puts_integer_ge
    assert_equal Crystallizer.ruby2crystal("puts a > b"), "puts(a > b)\n"
  end

  def test_puts_integer_mod
    assert_equal Crystallizer.ruby2crystal("puts a % 2 == 0"), "puts(a % 2 == 0)\n"
  end

  def test_puts_integer_mod2
    assert_equal Crystallizer.ruby2crystal("puts a & 1 == 0"), "puts(a & 1 == 0)\n"
  end

  def test_puts_inline
    assert_equal Crystallizer.ruby2crystal('puts "#{a} #{b}"'), "puts(a.to_s + ' ' + b.to_s)\n"
  end
end
