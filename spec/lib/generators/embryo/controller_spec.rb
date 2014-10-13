require "generators/embryo/controller"
require "active_support/core_ext/string"

module Embryo
  RSpec.describe ControllerGenerator, :files, :stdout do
    describe "generating a basic controller" do
      before { create_generator("widget").invoke_all }

      it "generates the correct controller" do
        path = "app/controllers/widgets_controller.rb"
        expect(File.read path).to eq sample_file_data("controller_example.rb")
      end

      it "generates the correct controller spec" do
        path = "spec/controllers/widgets_controller_spec.rb"
        expect(File.read path).to eq sample_file_data("namespaced_controller_example.rb")
      end
    end

    describe "generating a namespaced controller" do
      before { create_generator("admin/local/widget").invoke_all }

      it "generates the correct controller" do
        path = "app/controllers/admin/local/widgets_controller.rb"
        expect(File.read path).to eq sample_file_data("controller_spec_example.rb")
      end

      it "generates the correct controller spec" do
        path = "spec/controllers/admin/local/widgets_controller_spec.rb"
        expect(File.read path).to eq sample_file_data("namespaced_controller_spec_example.rb")
      end
    end

    def create_generator(argument)
      ControllerGenerator.new([argument]).tap do |generator|
        allow(generator).to receive :generate
      end
    end

    def sample_file_data(name)
      File.read File.join(File.dirname(__FILE__), "../../../data/", name)
    end
  end
end
