module Embryo
  class Rspec
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.require_gem "rspec-rails", "~> 3.0", group: :test
      @filesystem.write "spec/spec_helper.rb", spec_helper_data
      @filesystem.write "spec/rails_helper.rb", rails_helper_data
    end

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
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
'
    end
  end
end
