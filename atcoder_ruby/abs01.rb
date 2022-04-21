# https://atcoder.jp/contests/abs/tasks/abc086_a
a, b = gets.split.map(&:to_i)
if a * b % 2 == 0
  puts "Even"
else
  puts "Odd"
end
