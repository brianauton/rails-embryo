require "rails/generators"
require "embryo/gemfile"

class EmbryoGenerator < Rails::Generators::Base
  def alter_gemfile
    gemfile = Embryo::Gemfile.current
    gemfile.remove_noise
    gemfile.write
  end
end
