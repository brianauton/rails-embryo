module Embryo
  class RubyTemplate
    def text
      code.join("\n") + "\n"
    end

    protected

    def indent(code)
      if code.is_a? Array
        code.map { |sub_code| indent sub_code }
      else
        "  " + code
      end
    end
  end
end
