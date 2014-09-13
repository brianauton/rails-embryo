module Embryo
  module GeneratorHelpers
    module Files
      def duplicate_file(source, destination)
        create_file source, File.read(destination) if File.exist? destination
      end

      def append_file(path, *args)
        File.exist?(path) ? super : create_file(path, *args)
      end

      def application_name
        if Rails.respond_to? :application
          Rails.application.class.parent_name.underscore
        else
          "unknown"
        end
      end
    end
  end
end
