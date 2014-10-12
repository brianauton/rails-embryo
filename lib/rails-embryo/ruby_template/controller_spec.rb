require "rails-embryo/ruby_template"

module Embryo
  class RubyTemplate::ControllerSpec < RubyTemplate
    def initialize(name, action_templates)
      @name = name
      @action_templates = action_templates
    end

    def path
      "spec/controllers/#{@name.underscore.pluralize}_controller_spec.rb"
    end

    protected

    def code
      [
       "require 'rails_helper'",
       "",
       "RSpec.describe #{@name.camelize.pluralize}Controller do",
       *indent(@action_templates.map(&:controller_spec_code)),
       "end"
      ]
    end
  end
end
