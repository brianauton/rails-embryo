require "rails-embryo"

module Embryo
  class DeviseGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      gem "devise"
      create_file "spec/support/devise.rb", devise_helper_data
      update_environments
    end

    private

    def devise_helper_data
'RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end
'
    end

    def update_environments
      ["development", "test"].each do |env|
        if File.exist? "config/environments/#{env}.rb"
          inject_into_file "config/environments/#{env}.rb", before: "end\n" do
            '
  config.action_mailer.default_url_options = { host: "localhost" }
'
          end
        end
      end
    end
  end
end
