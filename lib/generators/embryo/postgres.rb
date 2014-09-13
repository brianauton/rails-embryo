require "rails-embryo"

module Embryo
  class PostgresGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden
    include GeneratorHelpers::Files

    def install
      gem "pg"
      create_file "config/database.yml", database_yml_data
      create_file "config/database.yml.example", database_yml_data
      gitignore "config/database.yml"
    end

    private

    def database_yml_data
"default: &default
  adapter: postgresql
  template: template0

test:
  <<: *default
  database: #{application_name}_test

development:
  <<: *default
  database: #{application_name}_development
"
    end
  end
end
