require "embryo/gemfile"

module Embryo
  class TestSupport
    def initialize(gemfile)
      @gemfile = gemfile
    end

    def install
      @gemfile.require_gem "rspec-rails", "~> 3.0", group: :test
    end
  end
end
