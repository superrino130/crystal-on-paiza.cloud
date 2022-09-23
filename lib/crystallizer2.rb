require 'ripper'

module Crystallizer
  class << self

    def ruby2crystal(source)
      transpile(Ripper.lex(source))
    end

    private
      def transpile(s)
        arr = []
        bsearch_not_nil = index_not_nil = percom = marshalflg = false
        marshalcnt = 0
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
          when "include?"
            "includes?"
          when "update"
            "merge!"
          when "start_with?"
            "starts_with?"
          when "end_with?"
            "ends_with?"
          when "permutation"
            "each_permutation"
          when "combination"
            "each_combination"
          when "repeated_permutation"
            percom = true
            "each_repeated_permutation"
          when "repeated_combination"
            percom = true
            "each_repeated_combination"
          when "index"
            index_not_nil = true
            w[2]
          when "bsearch", "bsearch_index"
            bsearch_not_nil = true
            w[2]
          when "/="
            "//="
          when "/"
            "//"
          when "ceil"
            "ceil.to_i"
          when "floor"
            "floor.to_i"
          when "}"
            if arr[-1] == "{"
              "} of Int32 => Int32"
            elsif bsearch_not_nil
              bsearch_not_nil = false
              "}.not_nil!"
            else
              w[2]
            end
          when ")"
            if index_not_nil
              index_not_nil = false
              ").not_nil!"
            elsif percom
              percom = false
              ", true)"
            elsif marshalcnt == 2
              marshalcnt -= 1
              ".clone"
            elsif marshalcnt > 2
              marshalcnt -= 1
              ""
            elsif marshalcnt == 1
              marshalcnt = 0
              marshalflg = false
              ""
            else
              w[2]
            end
          when "]"
            if arr[-1] == "["
              "] of Int32"
            else
              w[2]
            end
          when "||"
            ds = ".not_nil!"
            if arr[-1].include?(ds)
              arr[-1].sub!(ds, "")
            elsif arr[-2].include?(ds)
              arr[-2].sub!(ds, "")
            end
            w[2]
          # when "next"
          #   if arr[-1] == "."
          #     arr.pop
          #     "+1"
          #   else
          #     w[2]
          #   end
          # when "pred"
          #   if arr[-1] == "."
          #     arr.pop
          #     "-1"
          #   else
          #     w[2]
          #   end
          when "Float"
            "Float64"
          when "Hash"
            "Hash(Int32, Int32)"
          when "Set"
            "Set(Int32)"
          when "Regexp"
            "Regex"
          when "Marshal"
            marshalflg = true
            ""
          else
            if marshalflg
              marshalcnt += 1 if w[2] == "("
              if marshalcnt == 2 && w[2] == "("
                ""
              elsif marshalcnt >= 2
                w[2]
              else
                ""
              end
            else
              w[2]
            end
          end
        end
        arr.join('')
          .gsub("read_line.chomp", "read_line")
          .gsub("&:", "&.")
      end
  end
end
