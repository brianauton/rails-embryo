require "rails-embryo/ruby_template/action"

module Embryo
  class RubyTemplate::Action::New < RubyTemplate::Action
    def controller_method_code
      method_code :new, "@#{model.singular} = #{model.class_name}.new"
    end

    def controller_spec_code
      spec_group_code "#new",
        spec_code("assigns a new #{model.singular}",
          "get :new",
          "expect(assigns :#{model.singular}).to be_a_new #{model.class_name}"),
        spec_code("succeeds", "get :new", "expect(response).to be_success")
    end
  end
end
