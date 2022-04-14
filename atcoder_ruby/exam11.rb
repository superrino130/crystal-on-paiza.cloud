# https://atcoder.jp/contests/abs/tasks/arc089_a
n = gets.to_i
txys = Array.new(n){ gets.split.map(&:to_i) }
t0 = x0 = y0 = 0
txys.each do |txy|
  kd = (txy[1] - x0).abs + (txy[2] - y0).abs
  td = (txy[0] - t0).abs
  if kd > td || kd % 2 != td % 2
      puts "No"
      exit
  end
  t0 = txy[0]
  x0 = txy[1]
  y0 = txy[2]
end
puts "Yes"
