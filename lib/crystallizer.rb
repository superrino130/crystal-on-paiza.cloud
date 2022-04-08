require 'ripper'

module Crystallizer
  class << self

    def ruby2crystal(source, **config)
      @globals = []
      {:nullable=>false}.each do |k,v|
        instance_variable_set("@#{k}", config[k] || v)
      end
      transpile(Ripper.sexp(source)).gsub(/\n+/, "\n")
    end

    private
      def delim(s)
        if s.kind_of?(Array)
          s.map{|line| "#{line}\n" }.join
        else
          "#{s}\n"
        end
      end

      def transpile(s)
        if s.instance_of?(String) then
          s
        elsif s.instance_of?(Array) && s[0].instance_of?(Symbol) then
          case s[0]
          when :program, :bodystmt  #, :else
            s[1].map{|e| delim(transpile(e))}.join

          #when :if, :elsif
          #  s[2].map{|e| delim(transpile(e))}.join

          when :assign
            delim(transpile(s[1]) + " = " + transpile(s[2]))

          when :massign
            delim(s[1].map{ transpile(_1) }.join(", ") + " = " + transpile(s[2]))

          when :var_field, :var_ref
            if [:@gvar, :@ivar, :@cvar].include?(s[1][0])
              @globals << s[1][1][1..-1]
              s[1][1][1..-1]
            elsif s[1][0]==:@const
              (s[0]==:var_field ? "const " : "") + s[1][1].downcase
            else
              s[1][1]
            end

          when :next
            delim("next")

          when :break
            delim("break")

          when :void_stmt
            "" # this happens when rip "if true then # do nothing end" type of code

          when :binary
            if s[2] == :<< then
              "push!(#{transpile(s[1])}, #{transpile(s[3])})"
            elsif s[1][0] == :string_literal && s[2] == :% then
              if s[3][0] == :array then
                "@sprintf(#{transpile(s[1][1][1])},#{s[3][1].map{|e| transpile(e)}.join(',')})"
              else
                "@sprintf(#{transpile(s[1][1][1])},#{transpile(s[3])})"
              end
            else
              case s[2]
              when :or
                operator = "or"
              when :and
                operator = "ans"
              when :^
                operator = "^"
              when :**
                operator = "**"
              when :===
                operator = "=="
              else
                operator = s[2].to_s
              end
              transpile(s[1]) + " " + operator + " " + transpile(s[3])
            end

          when :opassign
            delim(transpile(s[1]) + " " + transpile(s[2]) + " " + transpile(s[3]))

          when :unary
            case s[1]
            when :not, :!
              "!" + transpile(s[2])
            when :-@
              "(-" + transpile(s[2]) + ")"
            when :~
              "~" + transpile(s[2])
            else
              transpile(s[2])
            end

          when :paren
            "(" + transpile(s[1][0]) + ")"

          when :arg_paren
            transpile(s[1])

          when :brace_block
            "{ |" + s[1] + "| " + s[2] + " }"

          when :do_block
            s[1]
          when :symbol
            transpile(s[1])

          when :symbol_literal
            transpile(s[1])

          when :string_literal
            s[1][1..].map{ transpile(_1) }.join(" + ")

          when :string_embexpr
            case s[1][0][0]
            when :var_ref
              transpile(s[1][0][1])
            when :binary
              "(" + s[1][0][1..].map{ transpile(_1) }.join(" ") + ").to_s"
            end

          when :field, :call
            case s[1][1][1]
            when "Math"
              "Math." + transpile(s[3][1])
            when "Random"
              case s[3][1]
              when "rand"
                "rand()"
              else
                transpile(s[3][1])
              end
            when "gets"
              if s[3][1] == "chomp"
                "read_line"
              else
                "read_line." + transpile(s[3][1])
              end

            else
              case s[3][1]
              when "dup"
                "copy(#{transpile(s[1])})"

              when "shift"
                "shift!(#{transpile(s[1])})"

              when "to_f"
                "float(#{transpile(s[1])})"

              when "to_i", "to_int"
                "trunc(Int64,parse(string(#{transpile(s[1])})))"

              when "truncate"
                "trunc(#{transpile(s[1])})"

              when "chr"
                "Char(#{transpile(s[1])})"

              when "ord"
                "Int(#{transpile(s[1])})"

              when "class"
                "typeof(#{transpile(s[1])})"

              when "to_s"
                "string(#{transpile(s[1])})"

              when "even?"
                "iseven(#{transpile(s[1])})"

              when "odd?"
                "isodd(#{transpile(s[1])})"

              when "infinite?"
                "isinf(#{transpile(s[1])})"

              when "finite?"
                "isfinite(#{transpile(s[1])})"

              when "zero?"
                "(#{transpile(s[1])}==0)"

              when "integer?"
                "(typeof(#{transpile(s[1])})==Int64)"

              when "nan?"
                "isnan(#{transpile(s[1])})"

              when "abs", "magnitude"
                "abs(#{transpile(s[1])})"

              when "ceil", "floor"
                "#{s[3][1]}(Int64,#{transpile(s[1])})"

              when "size"
                transpile(s[1]) + ".size"

              when "count"
                transpile(s[1]) + ".count"

              when "next", "succ"
                "(#{transpile(s[1])}+1)"

              when "pred"
                "(#{transpile(s[1])}-1)"

              when "next_float"
                "(nextfloat(#{transpile(s[1])}))"

              when "prev_float"
                "(prevfloat(#{transpile(s[1])}))"

              when "round"
                "round(Int64,#{transpile(s[1])})"

              else
                "#{transpile(s[1])}.#{transpile(s[3])}"

              end
            end

          when :array
            s[1].nil? ? "[]" : "["+s[1].map{|e| transpile(e[1])}.join(",")+"]"

          when :@CHAR
            "'" + s[1][1] + "'"

          when :@ident, :@int, :@kw, :@op
            if s[0]==:@int && s[1][0..1]=="0x" then
              "(#{s[1]}+0)" # Promote to Int64 from smaller numbers for cases like spec/core/float/divide_spec.rb (otherwise 91.1/-0xffffffff fails)
            else
              s[1]
            end

          when :string_content
            s[1].nil? ? "" : s[1..-1].map{|e| transpile(e)}.join(",")

          when :@tstring_content
            '"' + s[1] + '"'

          # commented out for simplification
          #when :vcall

          when :command
            case s[1][1]
            when "p", "puts"
              c = "puts"
            when "print"
              c = "print"
            else
              c = transpile(s[1])
            end
            delim(c + "(" + transpile(s[2]) + ")")
            # delim(c + "(" + transpile(s[2][1][0]) + ")")

          when :method_add_block
            t = s[1][0]==:call ? s : s[1]
            if ["each", "each_with_index"].include?(t[1][3][1])
              a = [transpile(t[1])]
              if t[2][0] == :do_block
                a[-1] += " do |" + t[2][1][1][1].map{ transpile(_1) }.join(", ") + "|"
              end
              if t[2][2][0] == :bodystmt
                a << transpile(t[2][2][1][0])
              end
              a << "end"
              delim(a)
            elsif t[1][3][1]=="downto"
              delim([
                "for #{transpile(s[2][1])} in countfrom(#{transpile(t[1][1])}, -1)",
                "if #{transpile(s[2][1])}<#{transpile(t[2][1][1])} break end",
                s[2][2].map{|e| delim(transpile(e))}.join,
                "end"
              ])
            elsif t[1][3][1]=="times"
              delim([
                "for #{transpile(s[2][1]).nil? ? "___xyz___" : transpile(s[2][1]) } in 0:#{transpile(t[1][1])}-1",
                s[2][2].map{|e| delim(transpile(e))}.join,
                "end"
              ])
            else
              transpile(s[1])
            end

          when :method_add_arg
            if transpile(s[1][1])=="array" && transpile(s[1][3])=="new"
              "fill(#{s[2][1][1][1][1]}, #{s[2][1][1][0][1][1]})"
            elsif transpile(s[1][1])=="random" && transpile(s[1][3])=="rand"
              "rand(#{transpile(s[2][1])})"
            else
              case transpile(s[1][3])
              when "slice", "slice!"
                method = transpile(s[1][3]) == "slice!" ? "splice!" : transpile(s[1][3])
                start_index=0
                if s[2][1][1][0][0] == :dot2 || s[2][1][1][0][0] == :dot3
                  range = "#{transpile(s[2])}"
                elsif s[2][1][1].count == 1
                  range = "#{transpile(s[2])}"
                else
                  range = "#{transpile(s[2][1][1][0])}:#{start_index}+#{transpile(s[2][1][1][0])}+#{transpile(s[2][1][1][1])}"
                end
                "#{method}(#{transpile(s[1][1])}, #{range})"

              when "send"
                case transpile(s[2][1][1][0])
                when "==", "==="
                  # Prevent using === since in Julia === checks much strictly than Ruby.
                  "==(#{transpile(s[2][1][1][1])}, #{transpile(s[1][1])})"
                when "magnitude"
                  "abs(#{transpile(s[1][1])})"
                when "to_i", "to_int"
                  "trunc(Int64,parse(string(#{transpile(s[1][1])})))"
                when "truncate"
                  "trunc(#{transpile(s[1][1])})"
                when "-@"
                  "-(#{transpile(s[1][1])})"
                when "+@"
                  transpile(s[1][1])
                when "%", "modulo"
                  "#{transpile(s[1][1])}%#{transpile(s[2][1][1][1])}"
                when "fdiv"
                  "#{transpile(s[1][1])}/#{transpile(s[2][1][1][1])}"
                when "next", "succ"
                  "(#{transpile(s[1][1])}+1)"
                else
                  "#{transpile(s[2])}(#{transpile(s[1][1])})"
                end
              when "index"
                "findfirst(#{transpile(s[1][1])}, #{transpile(s[2])})"
              when "to_s"
                "base(#{transpile(s[2])}, #{transpile(s[1][1])})"
              when "to_i"
                "parse(Int, #{transpile(s[1][1])}, #{transpile(s[2])})"
              when "rindex"
                "findlast(#{transpile(s[1][1])}, #{transpile(s[2])})"
              when "div"
                "floor(#{transpile(s[1][1])}/#{transpile(s[2])})"
              when "modulo"
                "#{transpile(s[1][1])}%#{transpile(s[2])}"
              when "divmod"
                "divrem(#{transpile(s[1][1])},#{transpile(s[2])})"
              when "fdiv"
                "#{transpile(s[1][1])}/#{transpile(s[2])}"
              when "eql?"
                "===(#{transpile(s[1][1])}, #{transpile(s[2])})"
              when "round"
                "round(#{transpile(s[1][1])}, #{transpile(s[2])})"
              when "atan2"
                "atan2(#{transpile(s[2])})"
              when "gcd"
                "#{transpile(s[1][1])}.gcd(#{transpile(s[2])})"
              when "lcm"
                "#{transpile(s[1][1])}.lcm(#{transpile(s[2])})"
              when "gcdlcm"
                "[gcd(#{transpile(s[1][1])}, #{transpile(s[2])}), lcm(#{transpile(s[1][1])}, #{transpile(s[2])})]"
              when "key?", "has_key?"
                "haskey(#{transpile(s[1][1])}, #{transpile(s[2])})"
              when "rand"
                "int(rand() * #{transpile(s[2])})"
              # when "map"
              #   "map(#{transpile(s[2])})"

              else
                transpile(s[1]) + "(" + (transpile(s[2]) || "") + ")"
              end
            end

          when :args_add_block
            if s[1].empty?.!
              case s[1][0][0]
              when :paren
              when :string_literal
                transpile(s[1][0])
              else
                s[1].map{|e| transpile(e) }.join(", ")
              end
            else
              "&." + transpile(s[2])
            end

          when :while
            delim([
              "while " + transpile(s[1]),
               transpile(s[2]),
               "end"
            ])

          when :for
            delim([
              "for #{transpile(s[1])}::Int64 = #{transpile(s[2])}",
              transpile(s[3]),
              "end"
            ])

          when :if, :elsif
            additional_condition = s[3].nil?.! ? transpile(s[3]) : "end"
            delim([
              "#{s[0].to_s} " + transpile(s[1]),
              s[2].map{|e| delim(transpile(e))}.join,
              "#{additional_condition}"
            ])

          when :if_mod
            delim([
              "if " + transpile(s[1]),
              transpile(s[2]),
              "end"
            ])

          when :else
            delim([
              "else",
              s[1].map{|e| delim(transpile(e))}.join,
              "end"
            ])

          when :def
            code=transpile(s[3])
            globals_code=@globals.uniq.join(",")
            @globals=[]
            delim([
              "function #{s[1][1]}(#{transpile(s[2][1])})",
              (globals_code.length>0 ? delim("global #{globals_code}") : "") + code,
              "end"
            ])

          when :params
            s[1].nil? ? "" : s[1].map{|e| e[1]}.join(", ")

          when :dot2
            "#{transpile(s[1])}..#{transpile(s[2])}"

          when :dot3
            "#{transpile(s[1])}...#{transpile(s[2])}"

          when :aref, :aref_field
            aref_string = ->(type, list, index){
              # using #get function for Nullable compatible access
              type==:aref && @nullable ? "get(#{list}, #{index}, Nullable)" : list + "[#{index}]"
            }
            if !s[2].flatten.include?(:dot2) && !s[2].flatten.include?(:dot3) && s[2][1][0][0]!=:string_literal then
              aref_string.call(s[0], transpile(s[1]), transpile(s[2]))
            else
              if s[2].flatten.include?(:dot2)
                transpile(s[1]) + "[#{transpile(s[2][1][0][1])}..#{transpile(s[2][1][0][2])}]"
              elsif s[2].flatten.include?(:dot3)
                transpile(s[1]) + "[#{transpile(s[2][1][0][1])}...#{transpile(s[2][1][0][2])}]"
              else
                aref_string.call(s[0], transpile(s[1]), transpile(s[2]))
              end
            end

          when :const_path_ref
            if s[1][1][1]=="Float"
              case transpile(s[2])
              when "NAN"
                "NaN"
              when "INFINITY"
                "Inf"
              when "EPSILON"
                "eps()"
              when "MAX"
                "typemax(Float64)"
              when "MIN"
                "typemin(Float64)"
              else
                transpile(s[1])
              end
            else
              transpile(s[1])
            end

          when :return
            delim("return #{transpile(s[1])}")

          when :mrhs_new_from_args
            delim(s[1..].map{ transpile(_1) }.join(", "))

          else
            transpile(s[1])

          end

        elsif s.instance_of?(Array) && s[0].instance_of?(Array)
          s.map{|e| transpile(e)}.join
        elsif s.instance_of?(Symbol) && s[0].instance_of?(String)
          s[0]
        end
      end
  end
end
