# https://atcoder.jp/contests/typical90/tasks/typical90_a
def check(mid, a, k)
  cnt = 0
  cut = 0
  a.each do |x|
    if x - cut >= mid
      cut = x
      cnt += 1
    end
  end
  cnt >= k + 1
end

n, l = gets.split.map(&:to_i)
k = gets.to_i
a = gets.split.map(&:to_i)
a << l
a.unshift 0
puts (0..1000000000).bsearch{ |b| check(b, a, k).! } - 1
