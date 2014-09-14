require "rails-embryo"

module Embryo
  class PoltergeistGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      gem "poltergeist", "~> 1.0", group: :test
      gem "database_cleaner", group: :test
      create_file "spec/support/poltergeist.rb", poltergeist_helper_data
      create_file "spec/support/database_cleaner.rb", cleaner_helper_data
    end

    private

    def poltergeist_helper_data
'require "capybara/poltergeist"
Capybara.javascript_driver = :poltergeist
'
    end

    def cleaner_helper_data
'require "database_cleaner"

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before :example do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after :example do
    DatabaseCleaner.clean
  end
end
'
    end
  end
end
