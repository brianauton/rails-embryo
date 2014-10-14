require "rails-embryo/ruby_template/action"

module Embryo
  class RubyTemplate::Action::Update < RubyTemplate::Action
    def controller_method_code
      method_code :update,
        "if @#{model.singular}.update_attributes #{model.singular}_params",
        indent("redirect_to #{@model.plural_symbol}_path, notice: \"#{model.singular.capitalize} updated.\""),
        "else",
        indent("render :show"),
        "end"
    end

    def controller_spec_code
      spec_group_code "#update",
        spec_context_code("with valid attributes",
          spec_code("redirects to the index",
            "@#{model.singular} = create :#{model.symbol}",
            "post :update, id: @#{model.singular}.id, #{model.singular}: attributes_for(:#{model.symbol})",
            "expect(response).to redirect_to #{model.plural_symbol}_path"))
    end
  end
end
