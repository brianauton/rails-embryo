require "embryo/gemfile"

module Embryo
  class Filesystem
    def initialize(generator)
      @generator = generator
    end

    def require_gem(*args)
      gemfile.require_gem(*args)
    end

    def commit_changes
      gemfile.write
    end

    private

    def gemfile
      @gemfile ||= Gemfile.current generator: @generator
    end
  end
end
