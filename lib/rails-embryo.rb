require "rails/generators"
require "rails/generators/app_base"
require "embryo/filesystem"
require "embryo/test_support"
require "embryo/default_view"

class EmbryoGenerator < Rails::Generators::Base
  def install(*write_options)
    @write_options = write_options
    clean_files
    Embryo::TestSupport.new(filesystem).install
    Embryo::DefaultView.new(filesystem).install
    filesystem.commit_changes
    update_bundle
  end

  private

  def clean_files
    gemfile.remove_noise
  end

  def filesystem
    @filesystem ||= Embryo::Filesystem.new self, *@write_options
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
