require 'minitest/autorun'
require_relative '../lib/crystallizer2'

class TestOp < Minitest::Test
  def setup; end

  def test_div
    code = "x = 3 / 2"
    code2 = "x = 3 // 2"

    assert_equal Crystallizer.ruby2crystal(code), code2
  end
  
  def test_div2
    code = "x /= 2"
    code2 = "x //= 2"

    assert_equal Crystallizer.ruby2crystal(code), code2
  end


end
