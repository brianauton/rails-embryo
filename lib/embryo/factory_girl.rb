module Embryo
  class FactoryGirl
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.require_gem "factory_girl_rails", "~> 4.0", group: :test
      @filesystem.write "spec/support/factory_girl.rb", factory_girl_helper_data
    end

    def factory_girl_helper_data
'RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
'
    end
  end
end
