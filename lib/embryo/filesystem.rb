require "embryo/gemfile"

module Embryo
  class Filesystem
    def initialize(generator, *write_options)
      @generator = generator
      @write_options = write_options
      @write_cache = {}
    end

    def commit_changes
      @gemfile.write(*@write_options) if @gemfile
      sorted_cache.each { |path, data| @generator.create_file path, data, *@write_options }
    end

    def sorted_cache
      @write_cache.sort.to_h
    end

    def require_gem(*args)
      gemfile.require_gem(*args)
    end

    def gemfile
      @gemfile ||= Gemfile.current generator: @generator
    end

    def write(path, data)
      @write_cache[path] = data
    end
  end
end
