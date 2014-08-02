module Embryo
  class Gemfile
    attr_accessor :path, :data

    def initialize(path, generator: nil)
      @path = path
      @generator = generator
      @data = File.exist?(path) ? File.read(path) : ""
    end

    def require_gem(name, version, options = {})
      remove_gem name
      @data << "\n" unless @data[-1] == "\n"
      @data << "gem '#{name}', '#{version}'"
      options.each { |key, value| @data << ", #{key}: #{value.inspect}" }
      @data << "\n"
    end

    def remove_gem(name)
      @data = @data.each_line.reject do |line|
        line.match(/ *gem +'#{name}'/) or line.match(/ *gem +"#{name}"/)
      end.join
    end

    def write(force: false)
      @generator.create_file path, data, force: force
    end

    def self.current(generator: nil)
      new "Gemfile", generator: generator
    end
  end
end
