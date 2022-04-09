require_relative 'lib/crystallizer2'
require 'ripper'

# File.open(ARGV[0].sub(".\\", "").sub(".rb", ".cr"), "w") do |w|
#   source = File.open(ARGV[0]){ _1.read }
#   transcode = Crystallizer::ruby2crystal(source)
#   w.write transcode
# end

filename = "atcoder/exam11.rb"

code = File.open(filename){ _1.read }
transcode = Crystallizer::ruby2crystal(code)
# pp Ripper.sexp(code)
puts transcode
