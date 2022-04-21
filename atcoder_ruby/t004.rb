# https://atcoder.jp/contests/typical90/tasks/typical90_d
h, w = gets.split.map(&:to_i)
a = Array.new(h){ gets.split.map(&:to_i) }
b = Array.new(h, 0)
h.times do |i|
  b[i] = a[i].sum
end
c = Array.new(w, 0)
d = a.transpose
w.times do |i|
  c[i] = d[i].sum
end
h.times do |i|
  e = Array.new(w, 0)
  w.times do |j|
    e[j] = b[i] + c[j] - a[i][j]
  end
  puts e.join(" ")
end
