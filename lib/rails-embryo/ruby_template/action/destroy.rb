require "rails-embryo/ruby_template/action"

module Embryo
  class RubyTemplate::Action::Destroy < RubyTemplate::Action
    def controller_method_code
      method_code :destroy,
        "if @#{model.singular}.destroy",
        indent("redirect_to #{@model.plural_symbol}_path, notice: \"#{model.singular.capitalize} deleted.\""),
        "else",
        indent("redirect_to #{@model.plural_symbol}_path, alert: \"Couldn't delete #{model.singular}.\""),
        "end"
    end

    def controller_spec_code
      spec_group_code "#destroy",
        spec_context_code("when successful",
          spec_before_code(
            "@#{model.singular} = create :#{model.symbol}",
            "delete :destroy, id: @#{model.singular}.id"
          ),
          spec_code("destroys the #{model.singular}",
            "expect(#{model.class_name}.all).not_to include @#{model.singular}"),
          spec_code("redirects to the index",
            "expect(response).to redirect_to #{model.plural_symbol}_path"))
    end
  end
end
