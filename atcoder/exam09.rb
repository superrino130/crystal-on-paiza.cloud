# https://atcoder.jp/contests/abs/tasks/abc085_c
n, y = gets.split.map(&:to_i)
0.upto(y / 10000) do |a|
  0.upto(y / 5000) do |b|
    if a * 10000 + b * 5000 + (n - a - b) * 1000 == y && a + b <= n
      puts "#{a} #{b} #{n - a - b}"
      exit
    end
  end
end
puts "-1 -1 -1"