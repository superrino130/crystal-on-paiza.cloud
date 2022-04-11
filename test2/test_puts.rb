require 'minitest/autorun'
require_relative '../lib/crystallizer2'

class TestPuts < Minitest::Test
  def setup; end

  def ae(code, code2)
    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_puts_integer
    code = "puts n"
    code2 = "puts n"
    ae(code, code2)
  end

  def test_puts_integer_add
    code = "puts a + b"
    code2 =  "puts a + b"
    ae(code, code2)
  end

  def test_puts_integer_div
    code = "puts a / b"
    code2 = "puts a // b"
    ae(code, code2)
  end

  def test_puts_inline
    code =<<-'EOF'
    puts "#{a + b} #{s}"
    EOF
    code2 =<<-'EOF'
    puts "#{a + b} #{s}"
    EOF

    ae(code, code2)
  end
end
