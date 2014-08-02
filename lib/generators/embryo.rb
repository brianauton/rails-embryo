require "rails/generators"
require "generators/embryo/ruby_version"
require "generators/embryo/default_view"
require "embryo/filesystem"
require "embryo/test_support"
require "embryo/template_support"

class EmbryoGenerator < Rails::Generators::Base
  def install(force: false, bundle: false)
    @force = force || options.force?
    clean_files
    add_embryo_gem
    invoke "embryo:ruby_version"
    Embryo::TestSupport.new(filesystem).install
    Embryo::TemplateSupport.new(filesystem).install
    invoke "embryo:default_view"
    filesystem.commit_changes
    update_bundle if bundle
  end

  private

  def clean_files
    gemfile.remove_noise
  end

  def add_embryo_gem
    filesystem.require_gem "rails-embryo", "~> #{Rails::Embryo::VERSION}"
  end

  def filesystem
    @filesystem ||= Embryo::Filesystem.new self, force: @force
  end

  def gemfile
    filesystem.gemfile
  end

  def update_bundle
    command = "bundle install"
    if `which bundle`.strip.present?
      say_status :run, command
      `#{command}`
    else
      say_status :skip, command, :yellow
    end
  end
end
