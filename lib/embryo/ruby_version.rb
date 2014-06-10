module Embryo
  class RubyVersion
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.write ".ruby-version", "2.1.2\n"
      @filesystem.write ".ruby-gemset", "#{@filesystem.application_name}\n"
    end
  end
end
