# https://atcoder.jp/contests/typical90/tasks/typical90_h
n = gets.to_i
s = gets.chomp
atcoder = "atcoder"
MOD = 10**9 + 7
dp = Array.new(n + 1){ Array.new(8, 0) }
dp[0][0] = 1
n.times do |i|
  7.times do |j|
    if s[i] == atcoder[j]
      dp[i + 1][j + 1] += dp[i][j] % MOD
    end
    dp[i + 1][j] += dp[i][j] % MOD
  end
  dp[i + 1][-1] += dp[i][-1] % MOD
end
puts dp[-1][-1] % MOD