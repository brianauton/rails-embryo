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
    add_embryo_gem
    invoke "embryo:ruby_version"
    invoke "embryo:rspec"
    invoke "embryo:factory_girl"
    invoke "embryo:capybara"
    invoke "embryo:poltergeist"
    invoke "embryo:template_support"
    invoke "embryo:default_view"
    clean_files
  end

  private

  def clean_files
    gsub_file "Gemfile", /^#.*$/, "", verbose: false
    gsub_file "Gemfile", /\n\n+/, "\n", verbose: false
    append_to_file "Gemfile", "\n\n"
  end

  def add_embryo_gem
    gem "rails-embryo", "~> #{Rails::Embryo::VERSION}", group: :development
  end
end
