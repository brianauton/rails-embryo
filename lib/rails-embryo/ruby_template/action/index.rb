require "rails-embryo/ruby_template/action"

module Embryo
  class RubyTemplate::Action::Index < RubyTemplate::Action
    def controller_method_code
      method_code :index, "@#{model.plural} = #{model.class_name}.all"
    end

    def controller_spec_code
      spec_group_code "#index",
        spec_code("assigns the collection of #{model.plural}",
          "#{model.singular} = create :#{model.symbol}",
          "get :index",
          "expect(assigns :#{model.plural}).to eq [#{model.singular}]"),
        spec_code("succeeds", "get :index", "expect(response).to be_success")
    end
  end
end
