require "rails-embryo/ruby_template"

module Embryo
  class RubyTemplate::ControllerSpec < RubyTemplate
    def initialize(model, action_templates)
      @model = model
      @action_templates = action_templates
    end

    def path
      "spec/controllers/#{@model.plural_path}_controller_spec.rb"
    end

    protected

    def code
      [
       "require 'rails_helper'",
       "",
       "RSpec.describe #{@model.plural_class_name}Controller do",
       *indent_separated(@action_templates.map(&:controller_spec_code)),
       "end"
      ]
    end
  end
end
