# https://atcoder.jp/contests/typical90/tasks/typical90_f
n, k = gets.split.map(&:to_i)
s = gets.chomp.chars

s_idx = {}

n.times do |i|
  if s_idx.key?(s[i])
    s_idx[s[i]] << i
  else
    s_idx[s[i]] = [i]
  end
end

alphs = s_idx.keys.sort

ans = []
memo = 0
while k > 0
  alphs.each do |a|
    next if s_idx[a][-1] < memo
    j = s_idx[a].bsearch_index{ |b| b >= memo }
    if k + s_idx[a][j] <= n
      memo = s_idx[a][j] + 1
      ans << a
      k -= 1
      break
    end
  end
end
puts ans.join("")
