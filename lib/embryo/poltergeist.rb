module Embryo
  class Poltergeist
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.require_gem "poltergeist", "~> 1.0", group: :test
      @filesystem.write "spec/support/poltergeist.rb", poltergeist_helper_data
    end

    def poltergeist_helper_data
'require "capybara/poltergeist"
Capybara.javascript_driver = :poltergeist
'
    end
  end
end
