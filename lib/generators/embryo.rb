require "rails/generators"
require "generators/embryo/default_view"
require "generators/embryo/template_support"
require "generators/embryo/rspec"
require "generators/embryo/factory_girl"
require "generators/embryo/capybara"
require "generators/embryo/poltergeist"
require "generators/embryo/devise"
require "generators/embryo/application"
require "generators/embryo/postgres"

class EmbryoGenerator < Rails::Generators::Base
  def install(force: false, bundle: false)
    invoke "embryo:rspec"
    invoke "embryo:factory_girl"
    invoke "embryo:capybara"
    invoke "embryo:poltergeist"
    invoke "embryo:template_support"
    invoke "embryo:default_view"
    invoke "embryo:devise"
    invoke "embryo:application"
    invoke "embryo:postgres"
    clean_files
  end

  private

  def clean_files
    gsub_file "Gemfile", /^#.*$/, "", verbose: false
    gsub_file "Gemfile", /\n\n+/, "\n", verbose: false
    append_to_file "Gemfile", "\n\n"
  end
end
