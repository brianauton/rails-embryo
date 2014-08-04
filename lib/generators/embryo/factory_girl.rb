require "rails-embryo"

module Embryo
  class FactoryGirlGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      gem "factory_girl_rails", "~> 4.0", group: :test
      create_file "spec/support/factory_girl.rb", factory_girl_helper_data
    end

    private

    def factory_girl_helper_data
'RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
'
    end
  end
end
