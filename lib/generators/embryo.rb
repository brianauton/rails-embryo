require "rails/generators"
require "generators/embryo/ruby_version"
require "generators/embryo/default_view"
require "generators/embryo/template_support"
require "generators/embryo/rspec"
require "generators/embryo/factory_girl"
require "generators/embryo/capybara"
require "generators/embryo/poltergeist"

class EmbryoGenerator < Rails::Generators::Base
  def install(force: false, bundle: false)
    clean_files
    add_embryo_gem
    invoke "embryo:ruby_version"
    invoke "embryo:rspec"
    invoke "embryo:factory_girl"
    invoke "embryo:capybara"
    invoke "embryo:poltergeist"
    invoke "embryo:template_support"
    invoke "embryo:default_view"
  end

  private

  def clean_files
    gsub_file "Gemfile", /^#/, ""
    gsub_file "Gemfile", /\n\n+/, "\n\n"
    gsub_file "Gemfile", /\n+$/, "\n"
  end

  def add_embryo_gem
    gem "rails-embryo", "~> #{Rails::Embryo::VERSION}"
  end
end
