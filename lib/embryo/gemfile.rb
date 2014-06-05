module Embryo
  class Gemfile
    attr_accessor :path, :data

    def initialize(path, generator: nil)
      @path = path
      @generator = generator
      @data = File.read(path) if File.exist?(path)
    end

    def remove_noise
      @data = @data.each_line.select { |line| line[0] != "#" }.join
      @data.gsub!(/\n\n+/, "\n\n")
      @data.gsub!(/\n+$/, "\n")
    end

    def write(force: false)
      @generator.create_file path, data, force: force
    end

    def self.current(generator: nil)
      new "Gemfile", generator: generator
    end
  end
end
