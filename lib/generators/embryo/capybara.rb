require "rails-embryo"

module Embryo
  class CapybaraGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      gem "capybara", "~> 2.0", group: :test
      gem "launchy", "~> 2.0", group: :test
      create_file "spec/support/capybara.rb", capybara_helper_data
    end

    private

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
