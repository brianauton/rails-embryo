require "rails/generators"
require "embryo/gemfile"

class EmbryoGenerator < Rails::Generators::Base
  def alter_gemfile(*write_options)
    gemfile = Embryo::Gemfile.current generator: self
    gemfile.remove_noise
    gemfile.write(*write_options)
  end
end
