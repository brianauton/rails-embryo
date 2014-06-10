require "embryo/gemfile"
require "tmpdir"
require "active_support/inflector"

module Embryo
  class Filesystem
    def initialize(generator, *write_options)
      @generator = generator
      @write_options = write_options
      @write_cache = {}
    end

    def commit_changes
      @gemfile.write(*@write_options) if @gemfile
      sorted_cache.each do |path, data|
        if data
          @generator.create_file path, data, *@write_options
        else
          @generator.remove_file path, *@write_options if File.exist? path
        end
      end
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

    def delete(path)
      @write_cache[path] = nil
    end

    def application_name
      File.basename Dir.getwd
    end

    def application_human_name
      application_name.titleize
    end
  end
end
