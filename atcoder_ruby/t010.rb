# https://atcoder.jp/contests/typical90/tasks/typical90_j
n = gets.to_i
a = Array.new(n + 1){ [0, 0] }
1.upto(n) do |i|
  cs, ps = gets.split.map(&:to_i)
  if cs == 1
    a[i][0] = ps + a[i - 1][0]
    a[i][1] = a[i - 1][1]
  else
    a[i][0] = a[i - 1][0]
    a[i][1] = ps + a[i - 1][1]
  end
end
q = gets.to_i
q.times do
  l, r = gets.split.map(&:to_i)
  puts "#{a[r][0] - a[l - 1][0]} #{a[r][1] - a[l - 1][1]}"
end
