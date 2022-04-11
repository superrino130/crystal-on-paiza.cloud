require 'ripper'

module Crystallizer
  class << self

    def ruby2crystal(source)
      transpile(Ripper.lex(source))
    end

    private
      def transpile(s)
        arr = []
        s.each_with_index do |w, i|
          arr << case w[2]
          when "gets", "readline"
            "read_line"
          when "/="
            "//="
          when "/"
            "//"
          when "<<"
            arr.pop if arr[-1] == " "
            ".push"
          when "next"
            if arr[-1] == "."
              arr.pop
              "+1"
            else
              "next"
            end
          when "Regexp"
            "Regex"
          when "include?"
            "includes?"
          else
            w[2]
          end
        end
        arr.join('')
          .gsub("read_line.chomp", "read_line")
          .gsub("&:", "&.")
      end
  end
end
