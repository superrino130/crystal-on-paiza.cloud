# https://atcoder.jp/contests/abs/tasks/abc081_b
n = gets.to_i
a = gets.split.map(&:to_i)
ans = 0
while a.all?{ |e| e % 2 == 0 }
  a.map!{ |e| e / 2 }
  ans += 1
end
puts ans
