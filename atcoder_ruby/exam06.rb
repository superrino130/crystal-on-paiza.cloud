# https://atcoder.jp/contests/abs/tasks/abc083_b
n, a, b = gets.split.map(&:to_i)
ans = 0
(1..n).each do |x|
  y = x
  t = 0
  while x > 0
    t += x % 10
    x /= 10
  end
  if a <= t && t <= b
    ans += y
  end
end
puts ans