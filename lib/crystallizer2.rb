require 'ripper'

module Crystallizer
  class << self

    def ruby2crystal(source)
      transpile(Ripper.lex(source))
    end

    private
      def transpile(s)
        arr = []
        s.map do |w|
          arr << case w[2]
          when "gets", "readline"
            "read_line"
          when "/="
            "//="
          when "/"
            "//"
          when "Array"
            if s.to_s.include?("to_i")
              if s.to_s.include?("split")
                "Array(Array(Int32))"
              else
                "Array(Int32)"
              end
            elsif s.to_s.include?("to_f")
              if s.to_s.include?("split")
                "Array(Array(Float64)"
              else
                "Array(Float64)"
              end
            else
              "Array()"
            end
          when "Regexp"
            "Regex"
          else
            w[2]
          end
        end
        arr.join('')
          .gsub(".chomp", "")
          .gsub("&:", "&.")
      end
  end
end
