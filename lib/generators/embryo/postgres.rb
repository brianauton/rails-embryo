require "rails-embryo"

module Embryo
  class PostgresGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden
    include GeneratorHelpers::Files

    def install
      gem "pg"
      create_file "config/database.yml", database_yml_data
      create_file "config/database.yml.example", database_yml_data
      append_file ".gitignore", gitignore_data
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

    def gitignore_data
      "/config/database.yml\n"
    end
  end
end
