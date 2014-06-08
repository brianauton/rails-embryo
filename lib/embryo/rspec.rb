require "embryo/gemfile"

module Embryo
  class Rspec
    def initialize(gemfile)
      @gemfile = gemfile
    end

    def install
      @gemfile.require_gem "rspec", "~> 3.0", group: :test
    end
  end
end
