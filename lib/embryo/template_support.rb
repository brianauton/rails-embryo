module Embryo
  class TemplateSupport
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.require_gem "haml", "~> 4.0"
      @filesystem.require_gem "haml-rails", ">= 0"
      @filesystem.require_gem "bootstrap-sass", "~> 3.0"
      @filesystem.write "app/views/layouts/application.html.haml", layout_data
      @filesystem.write "app/views/layouts/_navigation.html.haml", navigation_data
      @filesystem.write "app/views/layouts/_messages.html.haml", messages_data
      @filesystem.write "app/assets/javascripts/application.js", javascript_data
      @filesystem.write "app/assets/stylesheets/bootstrap-custom.css.scss", stylesheet_data
      @filesystem.delete "app/views/layouts/application.html.erb"
    end

    def layout_data
'!!! 5
%html(lang="en")
  %head
    %meta(charset="utf-8")
    %meta(http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1")
    %meta(name="viewport" content="width=device-width, initial-scale=1.0")
    %title ' + @filesystem.application_human_name + '
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
      = link_to "' + @filesystem.application_human_name + '", root_path, class: "navbar-brand"
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
  end
end
