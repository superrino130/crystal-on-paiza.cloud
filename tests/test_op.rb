require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestOp < Minitest::Test
  def setup; end

  def test_div
    code =<<-EOF
    x = 3 / 2
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "x = 3 // 2\n"
  end
  
  def test_div2
    code =<<-EOF
    x /= 2
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "x //= 2\n"
  end


end
