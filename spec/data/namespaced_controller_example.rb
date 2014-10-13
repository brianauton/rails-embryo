require 'rails_helper'

RSpec.describe WidgetsController do
  describe "#index" do
    it "succeeds" do
      get :index
      expect(response).to be_success
    end
  end
end
