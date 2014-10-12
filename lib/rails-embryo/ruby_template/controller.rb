require "rails-embryo/ruby_template"

module Embryo
  class RubyTemplate::Controller < RubyTemplate
    def initialize(name, action_templates)
      @name = name
      @action_templates = action_templates
    end

    def path
      "app/controllers/#{@name.underscore.pluralize}_controller.rb"
    end

    protected

    def code
      [
       "class #{@name.camelize.pluralize}Controller < ActionController",
       *indent(@action_templates.map(&:controller_method_code)),
       "end"
      ]
    end
  end
end
