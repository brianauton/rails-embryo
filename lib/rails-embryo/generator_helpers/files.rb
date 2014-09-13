module Embryo
  module GeneratorHelpers
    module Files
      def duplicate_file(source, destination)
        create_file source, File.read(destination) if File.exist? destination
      end

      def append_file(path, data)
        super if File.exist? path
      end
    end
  end
end
