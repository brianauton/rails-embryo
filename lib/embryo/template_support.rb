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
    end

    def layout_data
'!!! 5
%html(lang="en")
  %head
    %meta(charset="utf-8")
    %meta(http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1")
    %meta(name="viewport" content="width=device-width, initial-scale=1.0")
    %title Application
    = stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true
    = javascript_include_tag "application", "data_turbolinks_track" => true
    = csrf_meta_tags
  %body(role="document")
    .container(role="main")
      = yield
'
    end
  end
end
