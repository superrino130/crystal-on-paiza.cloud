require_relative 'lib/crystallizer'
require 'ripper'

code =<<EOF
n = gets.to_i
a = gets.split.map(&:to_i)
cnt = 0
max = 0
(0...n).each do |i|
  min = 10**9
  j = i
  while j < n
    min = a[j] if min > a[j]
    max = min * (j - i + 1) if max < min * (j - i + 1)
    j += 1
  end
  cnt = max if cnt < max
end
puts cnt
EOF

# pp Ripper.sexp(code)
puts Crystallizer::ruby2crystal(code)
