# https://atcoder.jp/contests/abs/tasks/abc085_c
n, y = gets.split.map(&:to_i)
0.upto(y / 10000) do |a|
  0.upto(y / 5000) do |b|
    0.upto(y / 1000) do |c|
      if a + b + c == n && a * 10000 + b * 5000 + c * 1000 == y
        puts "#{a} #{b} #{c}"
        exit
      end
      next if a * 10000 + b * 5000 + c * 1000 > y
    end
  end
end
puts "-1 -1 -1"