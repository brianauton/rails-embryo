require "embryo/gemfile"

module Embryo
  class Filesystem
    def initialize(generator, *write_options)
      @generator = generator
      @write_options = write_options
    end

    def require_gem(*args)
      gemfile.require_gem(*args)
    end

    def commit_changes
      gemfile.write(*@write_options)
    end

    private

    def gemfile
      @gemfile ||= Gemfile.current generator: @generator
    end
  end
end
