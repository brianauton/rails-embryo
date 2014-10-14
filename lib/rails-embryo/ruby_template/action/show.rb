require "rails-embryo/ruby_template/action"

module Embryo
  class RubyTemplate::Action::Show < RubyTemplate::Action
    def controller_method_code
      method_code :show
    end

    def controller_spec_code
      spec_group_code "#show",
        spec_before_code(
          "@#{model.singular} = create :#{model.symbol}",
          "get :show, id: @#{model.singular}.id"),
        spec_code("assigns the widget",
          "expect(assigns :#{model.singular}).to eq @#{model.singular}"),
        spec_code("succeeds",
          "expect(response).to be_success")
    end
  end
end
