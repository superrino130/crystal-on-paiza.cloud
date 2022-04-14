# https://atcoder.jp/contests/typical90/tasks/typical90_c
n = gets.to_i
ab = Array.new(n + 1){ [] }
f = Array.new(n + 1, 0)
(n - 1).times do
  a, b = gets.split.map(&:to_i)
  ab[a] << b
  ab[b] << a
end
que = []
f[1] = 1
que << 1
while que.empty?.!
  r = que.shift
  ab[r].each do |x|
    if f[x] == 0
      f[x] = f[r] + 1
      que << x
    end
  end
end
que << f.index(f.sort[-1])
f = Array.new(n + 1, 0)
f[que[0]] = 1
while que.empty?.!
  r = que.shift
  ab[r].each do |x|
    if f[x] == 0
      f[x] = f[r] + 1
      que << x
    end
  end
end
puts f.sort[-1]
