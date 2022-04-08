# https://atcoder.jp/contests/abs/tasks/abc088_b
n = gets.to_i
a = gets.split.map(&:to_i).sort.reverse
ans = 0
n.times do |i|
  if i % 2 == 0
    ans += a[i]
  else
    ans -= a[i]
  end
end
puts ans