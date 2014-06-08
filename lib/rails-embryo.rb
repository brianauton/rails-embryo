require "rails/generators"
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
end
