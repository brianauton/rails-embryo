require "embryo/default_view"

module Embryo
  describe DefaultView do
    describe "#install" do
      before do
        @filesystem = double write: nil
      end

      it "creates a routes file with the dashboard route" do
        content = a_string_including "root \"dashboard#index\""
        expect(@filesystem).to receive(:write).with "config/routes.rb", content
        DefaultView.new(@filesystem).install
      end

      it "creates a dashboard controller with index action" do
        content = a_string_including "def index"
        expect(@filesystem).to receive(:write).with "app/controllers/dashboard_controller.rb", content
        DefaultView.new(@filesystem).install
      end

      it "creates a controller spec for the dashboard index action" do
        content = a_string_including "get :index"
        expect(@filesystem).to receive(:write).with "spec/controllers/dashboard_controller_spec.rb", content
        DefaultView.new(@filesystem).install
      end

      it "creates a feature spec for the dashboard view" do
        content = a_string_including "visit \"/\""
        expect(@filesystem).to receive(:write).with "spec/features/dashboard_spec.rb", content
        DefaultView.new(@filesystem).install
      end
    end
  end
end
