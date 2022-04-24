# https://atcoder.jp/contests/typical90/tasks/typical90_cg
def divisors(n)
  l = []
  k = 1
  while k * k <= n
    if n % k == 0
      l << k
      if k * k != n
        l << n / k
      end
    end
    k += 1
  end
  l
end
n = gets.to_i
a = divisors(n)
cnt = 0
a.each do |k|
  divisors(n / k).each do |j|
    cnt += 1 if k <= j && j <= n / k / j
  end
end
puts cnt
