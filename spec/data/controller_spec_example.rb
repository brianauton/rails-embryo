require 'rails_helper'

RSpec.describe WidgetsController do
  describe "#index" do
    it "assigns the collection of widgets" do
      widget = create :widget
      get :index
      expect(assigns :widgets).to eq [widget]
    end

    it "succeeds" do
      get :index
      expect(response).to be_success
    end
  end

  describe "#new" do
    it "assigns a new widget" do
      get :new
      expect(assigns :widget).to be_a_new Widget
    end

    it "succeeds" do
      get :new
      expect(response).to be_success
    end
  end

  describe "#create" do
    context "with valid attributes" do
      before do
        post :create, widget: attributes_for(:widget)
      end

      it "creates a new widget" do
        expect(assigns :widget).to be_a Widget
      end

      it "redirects to the index on success" do
        expect(response).to redirect_to widgets_path
      end
    end
  end

  describe "#show" do
    before do
      @widget = create :widget
      get :show, id: @widget.id
    end

    it "assigns the widget" do
      expect(assigns :widget).to eq @widget
    end

    it "succeeds" do
      expect(response).to be_success
    end
  end

  describe "#update" do
    context "with valid attributes" do
      it "redirects to the index" do
        @widget = create :widget
        post :update, id: @widget.id, widget: attributes_for(:widget)
        expect(response).to redirect_to widgets_path
      end
    end
  end

  describe "#destroy" do
    context "when successful" do
      before do
        @widget = create :widget
        delete :destroy, id: @widget.id
      end

      it "destroys the widget" do
        expect(Widget.all).not_to include @widget
      end

      it "redirects to the index" do
        expect(response).to redirect_to widgets_path
      end
    end
  end
end
