module Embryo
  class DefaultView
    def initialize(filesystem)
      @filesystem = filesystem
    end

    def install
      @filesystem.write "config/routes.rb", routes_data
      @filesystem.write "app/controllers/dashboard_controller.rb", controller_data
      @filesystem.write "spec/controllers/dashboard_controller_spec.rb", controller_spec_data
      @filesystem.write "spec/features/dashboard_spec.rb", feature_spec_data
    end

    private

    def controller_data
'class DashboardController < ApplicationController
  def index
    render text: "Welcome"
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

describe DashboardController do
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

feature "Dashboard" do
  scenario "index view" do
    visit "/"
    expect(page).to have_content "Welcome"
  end
end
'
    end
  end
end