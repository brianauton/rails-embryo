module Embryo
  module GeneratorHelpers
    module Hidden
      def self.namespaces
        @namespaces ||= []
      end

      def self.included(generator)
        namespaces << generator.namespace
      end
    end
  end
end
