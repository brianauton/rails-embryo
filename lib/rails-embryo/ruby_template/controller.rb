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
       "class #{@model.plural_class_name}Controller < ApplicationController",
       indent("before_action :find_#{@model.singular}, only: [:show, :update, :destroy]"),
       *indented_action_methods,
       indent_section("private"),
       indent_section(finder_method),
       indent_section(params_method),
       "end"
      ]
    end

    def indented_action_methods
      @action_templates.map do |action|
        indent_section action.controller_method_code
      end
    end

    def finder_method
      method_code "find_#{@model.singular}",
        "@#{@model.singular} = #{@model.class_name}.find params[:id]"
    end

    def params_method
      method_code "#{@model.singular}_params",
        "params.fetch(:#{@model.singular})"
    end
  end
end
