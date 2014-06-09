module Embryo
  class Capybara
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.require_gem "capybara", "~> 2.0", group: :test
      @filesystem.require_gem "launchy", "~> 2.0", group: :test
      @filesystem.write "spec/support/capybara.rb", capybara_helper_data
    end

    def capybara_helper_data
'require "capybara/rails"
require "capybara/rspec"
RSpec.configure do |config|
  config.include Capybara::DSL, type: :feature
end
'
    end
  end
end
