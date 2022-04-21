# https://atcoder.jp/contests/typical90/tasks/typical90_h
n = gets.to_i
S = gets.chomp.chars
a = "atcoder".chars
MOD = 10**9 + 7
dp = Array.new(7 + 1){ Array.new(n + 1, 0) }
(n + 1).times do |i|
  (7 + 1).times do |j|
    dp[j][i] = if j == 0
      1
    elsif i == 0
      0
    elsif S[i - 1] == a[j - 1]
      (dp[j - 1][i - 1] + dp[j][i - 1]) % MOD
    else
      dp[j][i - 1] % MOD
    end
  end
end
puts dp[-1][-1]
