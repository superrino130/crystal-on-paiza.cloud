require 'minitest/autorun'
require_relative '../lib/crystallizer2'

class TestIf < Minitest::Test
  def setup; end

  def test_if
    code =<<-EOF
    if a == 0
      puts x
    end
    EOF
    code2 =<<-EOF
    if a == 0
      puts x
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_if_else
    code =<<-EOF
    if a == 0
      puts "Yes"
    else
      puts "No
    end
    EOF
    code2 =<<-EOF
    if a == 0
      puts "Yes"
    else
      puts "No
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end

  def test_if_elsif
    code =<<-EOF
    if a == 0
      puts "Yes"
    elsif a > 0
      puts "No
    else
      puts "None
    end
    EOF
    code2 =<<-EOF
    if a == 0
      puts "Yes"
    elsif a > 0
      puts "No
    else
      puts "None
    end
    EOF

    assert_equal Crystallizer.ruby2crystal(code), code2
  end
end
