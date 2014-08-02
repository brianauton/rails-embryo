require "rails/generators"

module Embryo
  class RubyVersionGenerator < Rails::Generators::Base
    def install
      create_file ".ruby-version", "2.1.2\n"
      create_file ".ruby-gemset", "#{File.basename Dir.getwd}\n"
    end
  end
end
