require "rails/generators"

module Embryo
  class PoltergeistGenerator < Rails::Generators::Base
    def install
      gem "poltergeist", "~> 1.0", group: :test
      create_file "spec/support/poltergeist.rb", poltergeist_helper_data
    end

    private

    def poltergeist_helper_data
'require "capybara/poltergeist"
Capybara.javascript_driver = :poltergeist
'
    end
  end
end
