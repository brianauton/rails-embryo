require "embryo/gemfile"

module Embryo
  class TestSupport
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.require_gem "rspec-rails", "~> 3.0", group: :test
    end
  end
end
