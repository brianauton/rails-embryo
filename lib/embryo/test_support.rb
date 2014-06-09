require "embryo/rspec"
require "embryo/factory_girl"
require "embryo/capybara"
require "embryo/poltergeist"

module Embryo
  class TestSupport
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      Rspec.new(@filesystem).install
      FactoryGirl.new(@filesystem).install
      Capybara.new(@filesystem).install
      Poltergeist.new(@filesystem).install
    end
  end
end
