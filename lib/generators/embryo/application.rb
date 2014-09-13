require "rails-embryo"
require "securerandom"

module Embryo
  class ApplicationGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden
    include GeneratorHelpers::Files

    def install
      create_file "config/secrets.yml", secrets_yml_data
      create_file "config/secrets.yml.example", secrets_yml_data
      gitignore "config/secrets.yml"
      duplicate_file "config/environments/staging.rb", "config/environments/production.rb"
    end

    private

    def secrets_yml_data
@secrets_yml_data ||= "development:
  secret_key_base: #{new_secret}

test:
  secret_key_base: #{new_secret}
"
    end

    def new_secret
      SecureRandom.hex 64
    end
  end
end
