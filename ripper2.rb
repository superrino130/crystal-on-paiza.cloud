require_relative 'lib/crystallizer2'
require 'ripper'

code =<<EOF
puts 'YES'
EOF

pp Ripper.lex(code)
puts Crystallizer::ruby2crystal(code)
