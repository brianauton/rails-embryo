require "rails/generators"
require "embryo/filesystem"

module Embryo
  class RubyVersionGenerator < Rails::Generators::Base
    def install
      create_file ".ruby-version", "2.1.2\n"
      create_file ".ruby-gemset", "#{filesystem.application_name}\n"
    end

    private

    def filesystem
      Filesystem.new self
    end
  end
end
