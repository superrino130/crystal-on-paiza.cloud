def check(cs)
  a = (0...2**N).to_a
  cmb = []

  a.combination(cs) do |xs|
    return cmb.size if xs.include?(0).! || cmb.empty?.!
    h = Hash.new(0)
    a.each do |i|
      f = false
      xs.each do |x|
        if (i ^ x).to_s(2).count('1') <= 1
          f = true
          h[i] += 1
          break
        end
      end
      break if f.!
    end
    if h.size == 2**N
      pt = xs.map{ _1.to_s(2).rjust(N, '0') }
      puts pt.join(', ')
      cmb << pt
    end
  end
end

N = gets.to_i
(2**N / N.next.to_f).ceil.upto(2**N) do |zz|
  break if check(zz) > 0
end