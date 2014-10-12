require "rails-embryo/ruby_template"

module Embryo
  class RubyTemplate::Action < RubyTemplate
    def initialize(resource)
      @singular = resource.underscore.split("/").last
      @plural = @singular.pluralize
      @collection = resource.camelize
    end

    protected

    def method_code(name, *code)
      ["def #{name}", *indent(code), "end"]
    end

    def spec_group_code(name, *specs)
      ["describe #{name.inspect} do", *indent(specs), "end"]
    end

    def spec_code(name, *code)
      ["it #{name.inspect} do", *indent(code), "end"]
    end
  end
end
