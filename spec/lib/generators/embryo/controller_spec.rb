require "generators/embryo/controller"
require "active_support/core_ext/string"

module Embryo
  RSpec.describe ControllerGenerator, :files, :stdout do
    describe "generating a controller file" do
      it "works with model name in singular form" do
        create_generator("widget").invoke_all
        path = "app/controllers/widgets_controller.rb"
        expect(File.read path).to eq sample_file_data("controller_example.rb")
      end

      it "works with model name in plural form" do
        create_generator("widgets").invoke_all
        path = "app/controllers/widgets_controller.rb"
        expect(File.read path).to eq sample_file_data("controller_example.rb")
      end

      it "works with a namespace" do
        create_generator("admin/local/widget").invoke_all
        path = "app/controllers/admin/local/widgets_controller.rb"
        expect(File.read path).to eq sample_file_data("namespaced_controller_example.rb")
      end
    end

    describe "generating the controller spec file" do
      it "works with model name in singular form" do
        create_generator("widget").invoke_all
        path = "spec/controllers/widgets_controller_spec.rb"
        expect(File.read path).to eq sample_file_data("controller_spec_example.rb")
      end

      it "works with model name in plural form" do
        create_generator("widgets").invoke_all
        path = "spec/controllers/widgets_controller_spec.rb"
        expect(File.read path).to eq sample_file_data("controller_spec_example.rb")
      end

      it "works with a namespace" do
        create_generator("admin/local/widget").invoke_all
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
