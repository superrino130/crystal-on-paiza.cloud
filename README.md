# crystal-on-paiza.cloud
1) paize.cloud を利用した開発環境の構築
2) `Ruby` を `Crystal` にトランスパイル
# paize.cloud を利用した開発環境の構築
not started

# `Ruby` を `Crystal` にトランスパイル
transpile from Ruby to crystal for Atcoder's Programming Contest

Ruby 2.7.1 to crystal 0.33.0

## Crystallizer
use `Ripper#sexp`

not started
## Crystallizer2
use `Ripper#lex`

ripper2.rb
```
require_relative 'lib/crystallizer2'
require 'ripper'

code =<<EOF
a = gets.split.map(&:to_i)
EOF

pp Ripper.lex(code)
puts Crystallizer::ruby2crystal(code)

# output
a = read_line.split.map(&.to_i)
```

writer2.rb
```
require_relative 'lib/crystallizer2'
require 'ripper'

filename = "atcoder_ruby/exam01.rb"

code = File.open(filename){ _1.read }
transcode = Crystallizer::ruby2crystal(code)

puts transcode

# output
# https://atcoder.jp/contests/abs/tasks/practice_1
a = read_line.to_i
b, c = read_line.split.map(&.to_i)
s = read_line
puts "#{a+b+c} #{s}"
```
# Transpile table
|Ruby|crystal|note|
|:--|:--|:--|
|gets, readline|read_line||
|collect|map||
|length|size||
|inject|reduce||
|find_all, filter|select||
|detect|find||
|find_index|index||
|append|push||
|prepend|unshift||
|take|first||
|delete_if|reject!||
|each_pair|each||
|keep_if, filter!|select!||
|key?, member?|has_key?||
|value?|has_value?||
|include?|includes?||
|update|merge!||
|start_with?|starts_with?||
|end_with?|ends_with?||
|permutation|each_permutation||
|combination|each_combination||
|repeated_permutation|each_permutation(,reuse=true)||
|repeated_combination|each_combination(,reuse=true)||
|index|index().not_nil!||
|bsearch|bsearch{}.not_nil!||
|/=|//=||
|/|//||
|{}|{} of Int32 => Int32|fixed|
|[]|[] of Int32|fixed|
|.next|+1|fixed|
|.pred|-1|fixed|
|Hash|Hash(Int32, Int32)|fixed|
|Regexp|Regex||
|gets.chomp|read_line||
|&:|&.||

# Solved problem
https://atcoder.jp/contests/abs/tasks/practice_1

https://atcoder.jp/contests/abs/tasks/abc086_a

https://atcoder.jp/contests/abs/tasks/abc081_a

https://atcoder.jp/contests/abs/tasks/abc081_b

https://atcoder.jp/contests/abs/tasks/abc087_b

https://atcoder.jp/contests/abs/tasks/abc083_b

https://atcoder.jp/contests/abs/tasks/abc088_b

https://atcoder.jp/contests/abs/tasks/abc085_b

https://atcoder.jp/contests/abs/tasks/abc085_c

https://atcoder.jp/contests/abs/tasks/arc065_a

https://atcoder.jp/contests/abs/tasks/arc089_a

https://atcoder.jp/contests/typical90/tasks/typical90_a

https://atcoder.jp/contests/typical90/tasks/typical90_b

https://atcoder.jp/contests/typical90/tasks/typical90_c

https://atcoder.jp/contests/typical90/tasks/typical90_d

https://atcoder.jp/contests/typical90/tasks/typical90_f # Manually change type

https://atcoder.jp/contests/typical90/tasks/typical90_g

https://atcoder.jp/contests/typical90/tasks/typical90_h
