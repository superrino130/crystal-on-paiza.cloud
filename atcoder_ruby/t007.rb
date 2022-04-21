# https://atcoder.jp/contests/typical90/tasks/typical90_g
n = gets.to_i
a = gets.split.map(&:to_i).sort
q = gets.to_i
q.times do
  b = gets.to_i
  c = a.bsearch_index{ |x| x > b } || n + 1
  if c == n + 1
    puts b - a[-1]
  elsif c.zero?
    puts a[0] - b
  else
    puts [a[c] - b, b - a[c - 1]].min
  end
end