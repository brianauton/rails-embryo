require "rails-embryo/ruby_template/action"

module Embryo
  class RubyTemplate::Action::Create < RubyTemplate::Action
    def controller_method_code
      method_code :create,
        "@#{model.singular} = #{model.class_name}.new #{model.singular}_params",
        "if @#{model.singular}.save",
        indent("redirect_to #{@model.plural_symbol}_path, notice: \"#{model.singular.capitalize} created.\""),
        "else",
        indent("render :new"),
        "end"
    end

    def controller_spec_code
      spec_group_code "#create",
        spec_context_code("with valid attributes",
          spec_before_code("post :create, #{model.singular}: attributes_for(:#{model.symbol})"),
          spec_code("creates a new #{model.singular}",
            "expect(assigns :#{model.singular}).to be_a #{model.class_name}"),
          spec_code("redirects to the index on success",
            "expect(response).to redirect_to #{model.plural_symbol}_path"))
    end
  end
end
