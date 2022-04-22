# https://atcoder.jp/contests/typical90/tasks/typical90_n
n = gets.to_i
a = gets.split.map(&:to_i).sort
b = gets.split.map(&:to_i).sort
ans = 0
n.times do |i|
  ans += (a[i] - b[i]).abs
end
puts ans