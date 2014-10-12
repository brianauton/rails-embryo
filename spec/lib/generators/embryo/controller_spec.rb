require "generators/embryo/controller"
require "active_support/core_ext/string"

module Embryo
  RSpec.describe ControllerGenerator, :files, :stdout do
    describe "generating a basic controller" do
      before { create_generator("widget").invoke_all }

      it "generates the correct controller" do
        path = "app/controllers/widgets_controller.rb"
        expect(File.read path).to eq <<-CODE.strip_heredoc
          class WidgetsController < ActionController
            def index
              @widgets = Widget.all
            end
          end
        CODE
      end

      it "generates the correct controller spec" do
        path = "spec/controllers/widgets_controller_spec.rb"
        expect(File.read path).to eq <<-CODE.strip_heredoc
          require 'rails_helper'

          RSpec.describe WidgetsController do
            describe "#index" do
              it "succeeds" do
                get :index
                expect(response).to be_success
              end
            end
          end
        CODE
      end
    end

    describe "generating a namespaced controller" do
      before { create_generator("admin/local/widget").invoke_all }

      it "generates the correct controller" do
        path = "app/controllers/admin/local/widgets_controller.rb"
        expect(File.read path).to eq <<-CODE.strip_heredoc
          class Admin::Local::WidgetsController < ActionController
            def index
              @widgets = Admin::Local::Widget.all
            end
          end
        CODE
      end

      it "generates the correct controller spec" do
        path = "spec/controllers/admin/local/widgets_controller_spec.rb"
        expect(File.read path).to eq <<-CODE.strip_heredoc
          require 'rails_helper'

          RSpec.describe Admin::Local::WidgetsController do
            describe "#index" do
              it "succeeds" do
                get :index
                expect(response).to be_success
              end
            end
          end
        CODE
      end
    end

    def create_generator(argument)
      ControllerGenerator.new([argument]).tap do |generator|
        allow(generator).to receive :generate
      end
    end
  end
end
