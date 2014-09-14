require "generators/embryo/default_view"

module Embryo
  describe DefaultViewGenerator, :files, :stdout do
    describe "#invoke_all" do
      it "creates a routes file with the dashboard route" do
        DefaultViewGenerator.new.invoke_all
        expect(File.read "config/routes.rb").to include "root \"dashboard#index\""
      end

      it "creates a dashboard controller with index action" do
        DefaultViewGenerator.new.invoke_all
        expect(File.read "app/controllers/dashboard_controller.rb").to include "def index"
      end

      it "creates a controller spec for the dashboard index action" do
        DefaultViewGenerator.new.invoke_all
        expect(File.read "spec/controllers/dashboard_controller_spec.rb").to include "get :index"
      end

      it "creates a feature spec for the dashboard view" do
        DefaultViewGenerator.new.invoke_all
        expect(File.read "spec/features/dashboard_spec.rb").to include "visit \"/\""
      end

      it "creates a javascript-enabled feature" do
        DefaultViewGenerator.new.invoke_all
        expect(File.read "spec/features/dashboard_spec.rb").to include ", :js"
      end
    end
  end
end
