require "rails/generators"
require "rails-embryo/ruby_template/controller"
require "rails-embryo/ruby_template/controller_spec"
require "rails-embryo/ruby_template/action/index"
require "rails-embryo/ruby_template/model"

module Embryo
  class ControllerGenerator < Rails::Generators::NamedBase
    def install
      create_file controller_template.path, controller_template.text
      create_file spec_template.path, spec_template.text
    end

    private

    def controller_template
      @controller_template ||= RubyTemplate::Controller.new model, action_templates
    end

    def spec_template
      @spec_template ||= RubyTemplate::ControllerSpec.new model, action_templates
    end

    def model
      @model ||= RubyTemplate::Model.new name
    end

    def action_templates
      [
       RubyTemplate::Action::Index.new(model),
      ]
    end
  end
end
