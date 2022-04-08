# https://atcoder.jp/contests/abs/tasks/abc087_b
a = gets.to_i
b = gets.to_i
c = gets.to_i
x = gets.to_i
ans = 0
(0..a).each do |aa|
  (0..b).each do |bb|
    (0..c).each do |cc|
      if aa * 500 + bb * 100 + cc * 50 == x
        ans += 1
      end
    end
  end
end
puts ans
