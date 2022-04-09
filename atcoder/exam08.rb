# https://atcoder.jp/contests/abs/tasks/abc085_b
n = gets.to_i
d = Array.new(n){ gets.to_i }.sort
ans = 1
(n - 1).times do |i|
  if d[i + 1] > d[i]
    ans += 1
  end
end
puts ans