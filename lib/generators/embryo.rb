require "rails/generators"
require "generators/embryo/ruby_version"
require "generators/embryo/default_view"
require "generators/embryo/template_support"
require "generators/embryo/rspec"
require "generators/embryo/factory_girl"
require "generators/embryo/capybara"
require "generators/embryo/poltergeist"
require "embryo/filesystem"

class EmbryoGenerator < Rails::Generators::Base
  def install(force: false, bundle: false)
    @force = force || options.force?
    clean_files
    add_embryo_gem
    invoke "embryo:ruby_version"
    invoke "embryo:rspec"
    invoke "embryo:factory_girl"
    invoke "embryo:capybara"
    invoke "embryo:poltergeist"
    invoke "embryo:template_support"
    invoke "embryo:default_view"
    update_bundle if bundle
  end

  private

  def clean_files
    gemfile.remove_noise
    filesystem.commit_changes
  end

  def add_embryo_gem
    gem "rails-embryo", "~> #{Rails::Embryo::VERSION}"
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
