require "rails-embryo/ruby_template"

module Embryo
  class RubyTemplate::Controller < RubyTemplate
    def initialize(model, action_templates)
      @model = model
      @action_templates = action_templates
    end

    def path
      "app/controllers/#{@model.plural_path}_controller.rb"
    end

    protected

    def code
      [
       "class #{@model.plural_class_name}Controller < ActionController",
       *indent(@action_templates.map(&:controller_method_code)),
       "end"
      ]
    end
  end
end
