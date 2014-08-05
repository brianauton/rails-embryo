require "rails/generators"

module Embryo
  module Model
    class AuthenticatedGenerator < Rails::Generators::NamedBase
      def install
        generate "embryo:model", ARGV.join(' ')
        generate "devise:install --quiet" unless File.exist? "config/initializers/devise.rb"
        generate "devise #{ARGV.first}"
        update_controllers
        update_factory
        update_seeds
      end

      private

      def update_controllers
        return if File.read("app/controllers/application_controller.rb").include? ":authenticate"
        inject_into_file "app/controllers/application_controller.rb", {
          after: "class ApplicationController < ActionController::Base\n"
        } do
          "  before_action :authenticate_#{singular_name}!\n\n"
        end
        inject_into_file "app/controllers/dashboard_controller.rb", {
          after: "class DashboardController < ApplicationController\n"
        } do
          "  skip_before_action :authenticate_#{singular_name}!\n\n"
        end
      end

      def update_factory
        inject_into_file "spec/factories/#{file_path}.rb", {
          after: /  factory :#{factory_name}.* do\n/
        } do
          factory_additions
        end
      end

      def factory_additions
'    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
'
      end

      def update_seeds
        append_file "db/seeds.rb", seed_data
      end

      def seed_data
"\n" + class_name + '.where(email: "' + singular_name + '@example.com").first_or_create password: "password"
'
      end

      def factory_name
        file_path.gsub "/", "_"
      end
    end
  end
end
