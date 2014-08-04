require "rails-embryo"

module Embryo
  class TemplateSupportGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      gem "haml", "~> 4.0"
      gem "haml-rails", ">= 0"
      gem "bootstrap-sass", "~> 3.0"
      create_file "app/views/layouts/application.html.haml", layout_data
      create_file "app/views/layouts/_navigation.html.haml", navigation_data
      create_file "app/views/layouts/_messages.html.haml", messages_data
      create_file "app/assets/javascripts/application.js", javascript_data
      create_file "app/assets/stylesheets/bootstrap-custom.css.scss", stylesheet_data
      remove_file "app/views/layouts/application.html.erb"
    end

    private

    def layout_data
'!!! 5
%html(lang="en")
  %head
    %meta(charset="utf-8")
    %meta(http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1")
    %meta(name="viewport" content="width=device-width, initial-scale=1.0")
    %title ' + application_human_name + '
    = stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true
    = javascript_include_tag "application", "data_turbolinks_track" => true
    = csrf_meta_tags
  %body(role="document")
    = render "layouts/navigation"
    .container(role="main")
      = render "layouts/messages"
      = yield
'
    end

    def navigation_data
'.navbar.navbar-inverse.navbar-fixed-top(role="navigation")
  .container
    .navbar-header
      %button.navbar-toggle(type="button" data-toggle="collapse" data-target=".navbar-collapse")
        %span.sr-only Toggle navigation
        %span.icon-bar
        %span.icon-bar
        %span.icon-bar
      = link_to "' + application_human_name + '", root_path, class: "navbar-brand"
    .navbar-collapse.collapse
      %ul.nav.navbar-nav
        %li= link_to "Home", root_path
'
    end

    def messages_data
'- {notice: "success", alert: "danger"}.each do |flash_key, alert_type|
  - if flash[flash_key].present?
    .alert(class="alert-#{alert_type}")
      %button.close(type="button" data-dismiss="alert" aria-hidden="true") &times;
      = flash[flash_key]
'
    end

    def javascript_data
'//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
'
    end

    def stylesheet_data
'@import "bootstrap";
@import "bootstrap/theme";
body { padding-top: 70px; }
'
    end

    def application_human_name
      File.basename(Dir.getwd).titleize
    end
  end
end
