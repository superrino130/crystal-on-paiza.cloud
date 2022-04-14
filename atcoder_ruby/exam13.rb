# https://atcoder.jp/contests/typical90/tasks/typical90_b
n = gets.to_i
[1, -1].repeated_permutation(n) do |xs|
  cnt = 0
  xs.each do |x|
    cnt += x
    if cnt < 0
      break
    end
  end
  if cnt == 0
    ans = ""
    xs.each do |x|
      if x == 1
        ans += "("
      else
        ans += ")"
      end
    end
    puts ans
  end
end