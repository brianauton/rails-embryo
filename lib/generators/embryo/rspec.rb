require "rails-embryo"

module Embryo
  class RspecGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      gem "rspec-rails", "~> 3.0", group: :test
      create_file "spec/spec_helper.rb", spec_helper_data
      create_file "spec/rails_helper.rb", rails_helper_data
      remove_dir "test"
    end

    private

    def spec_helper_data
'RSpec.configure do |config|
  config.color = true
  config.order = :random
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
'
    end

    def rails_helper_data
'ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end
'
    end
  end
end
