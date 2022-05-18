# crystal-on-paiza.cloud
This repository has two goals
1) Building a development environment using paize.cloud
2) transpile from Ruby to crystal for Atcoder's Programming Contest
# Building a development environment using paize.cloud
`paize.cloud` を利用した開発環境の構築

not started
# transpile from Ruby to crystal for Atcoder's Programming Contest
`Ruby` を `Crystal` にトランスパイル

Ruby 2.7.1 -> crystal 0.33.0

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

filename = "atcoder_ruby/abs00.rb"

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
|Set|Set(Int32)|fixed|
|Regexp|Regex||
|gets.chomp|read_line||
|&:|&.||
# Comparison of execution times(ms)
Typical competition professional 90 questions(競プロ典型 90 問)
|Problem No.|Ruby|crystal|note|
|:--:|--:|--:|:--|
|001|301|36|
|002|558|93|
|003|249|671|Array#push and Array#shift is slow|
|004|2010|519|
|006|961|98|
|007|653|156|
|008|171|25|Char is faster than String|
|010|269|107|
|014|149|50|
|085|1967|484|

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

https://atcoder.jp/contests/typical90/tasks/typical90_f # Manually change the type (Int32 -> Char etc.)

https://atcoder.jp/contests/typical90/tasks/typical90_g

https://atcoder.jp/contests/typical90/tasks/typical90_h

https://atcoder.jp/contests/typical90/tasks/typical90_j

https://atcoder.jp/contests/typical90/tasks/typical90_n # Manually change the type (0 -> 0i64)

https://atcoder.jp/contests/typical90/tasks/typical90_cg # Manually change the type (Int32 -> Int64 etc.)
