require "rails/generators"
require "embryo/gemfile"

class EmbryoGenerator < Rails::Generators::Base
  def install(*write_options)
    clean_gemfile(*write_options)
  end

  private

  def clean_gemfile(*write_options)
    gemfile = Embryo::Gemfile.current generator: self
    gemfile.remove_noise
    gemfile.write(*write_options)
  end
end
