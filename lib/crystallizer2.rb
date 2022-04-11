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
          when "collect"
            "map"
          when "length"
            "size"
          when "inject"
            "reduce"
          when "find_all", "filter"
            "select"
          when "detect"
            "find"
          when "find_index"
            "index"
          when "append"
            "push"
          when "prepend"
            "unshift"
          when "take"
            "first"
          when "delete_if"
            "reject!"
          when "each_pair"
            "each"
          when "keep_if", "filter!"
            "select!"
          when "key?", "member?"
            "has_key?"
          when "value?"
            "has_value?"
          when "update"
            "merge!"
          when "start_with?"
            "starts_with?"
          when "end_with?"
            "ends_with?"
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
