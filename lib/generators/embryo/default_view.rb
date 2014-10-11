require "rails-embryo"
require "rails/generators"

module Embryo
  class DefaultViewGenerator < Rails::Generators::Base
    include GeneratorHelpers::Hidden

    def install
      create_file "config/routes.rb", routes_data
      create_file "app/controllers/dashboard_controller.rb", controller_data
      create_file "spec/controllers/dashboard_controller_spec.rb", controller_spec_data
      create_file "spec/features/dashboard_spec.rb", feature_spec_data
    end

    private

    def controller_data
'class DashboardController < ApplicationController
  def index
    render text: "Welcome", layout: "application"
  end
end
'
    end

    def routes_data
'Rails.application.routes.draw do
  root "dashboard#index"
end
'
    end

    def controller_spec_data
'require "rails_helper.rb"

RSpec.describe DashboardController do
  describe "#index" do
    it "succeeds" do
      get :index
      expect(response).to be_success
    end
  end
end
'
    end

    def feature_spec_data
'require "rails_helper.rb"

RSpec.feature "Dashboard" do
  scenario "index view", :js do
    visit "/"
    expect(page).to have_content "Welcome"
  end
end
'
    end
  end
end
