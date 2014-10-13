module Embryo
  class RubyTemplate
    def text
      code.join("\n") + "\n"
    end

    protected

    def indent(code)
      if code.is_a? Array
        code.map { |sub_code| indent sub_code }
      elsif code == ""
        ""
      else
        "  " + code
      end
    end

    def indent_section(code)
      if code.is_a? Array
        [""] + indent(code)
      else
        ["", indent(code)]
      end
    end

    def indent_separated(code)
      if code.is_a? Array
        code.flat_map { |c| [indent(c), ""] }[0...-1]
      else
        indent code
      end
    end

    def method_code(name, *code)
      ["def #{name}", *indent(code), "end"]
    end
  end
end
