# https://atcoder.jp/contests/abs/tasks/arc065_a
s = gets.chomp
r = Regexp.new("^(dream|dreamer|erase|eraser)*$")
if r.match(s)
  puts "YES"
else
  puts "NO"
end