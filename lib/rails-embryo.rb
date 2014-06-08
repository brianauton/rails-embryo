require "rails/generators"
require "embryo/gemfile"
require "embryo/test_support"

class EmbryoGenerator < Rails::Generators::Base
  def install(*write_options)
    @write_options = write_options
    @gemfile = Embryo::Gemfile.current generator: self
    clean_files
    Embryo::TestSupport.new(@gemfile).install
    commit_changes
  end

  private

  def clean_files
    @gemfile.remove_noise
  end

  def commit_changes
    @gemfile.write(*@write_options)
  end
end
