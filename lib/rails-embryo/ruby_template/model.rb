require "active_support/core_ext/string"

module Embryo
  class RubyTemplate
    class Model
      def initialize(name)
        @name = name
      end

      def path
        @name.underscore
      end

      def plural_path
        path.pluralize
      end

      def singular
        path.split("/").last
      end

      def plural
        singular.pluralize
      end

      def class_name
        @name.camelize
      end

      def plural_class_name
        class_name.pluralize
      end

      def symbol
        path.gsub("/", "_")
      end

      def plural_symbol
        symbol.pluralize
      end
    end
  end
end
