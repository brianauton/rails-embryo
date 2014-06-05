module Embryo
  class Gemfile
    attr_accessor :path, :data

    def initialize(path)
      @path = path
      @data = File.read(path) if File.exist?(path)
    end

    def remove_noise
      @data = @data.each_line.select { |line| line[0] != "#" }.join
      @data.gsub!(/\n\n+/, "\n\n")
      @data.gsub!(/\n+$/, "\n")
    end

    def write
      File.open(path, "w") { |f| f.write data }
    end

    def self.current
      new "Gemfile"
    end
  end
end
