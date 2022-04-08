require 'minitest/autorun'
require_relative '../lib/crystallizer'

class TestIf < Minitest::Test
  def setup; end

  def test_if
    code =<<-EOF
    if a == 0
      puts x
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "if a == 0\nputs(x)\nend\n"
  end

  def test_if_else
    code =<<-EOF
    if a == 0
      puts "Yes"
    else
      puts "No
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "if a == 0\nputs(x)\nend\n"
  end

  def test_if_elsif
    code =<<-EOF
    if a == 0
      puts "Yes"
    elsif a > 0
      puts "No
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), "if a == 0\nputs(x)\nend\n"
  end
end
