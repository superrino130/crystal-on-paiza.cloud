require_relative 'lib/crystallizer'
require 'ripper'

code =<<EOF
eval'N,K,X,*A='+`dd`.split*?,
p A.map{_1-X*(K-K-=[K,_1/X].min)}.sort[..~K].sum
EOF

pp Ripper.sexp(code)
# puts Crystallizer::ruby2crystal(code)
