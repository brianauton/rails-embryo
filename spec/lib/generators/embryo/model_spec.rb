require "generators/embryo/model"

module Embryo
  describe ModelGenerator, :files, :stdout do
    describe "invoking rails:model generator" do
      before do
        @generator = ModelGenerator.new(["widget"])
        allow(@generator).to receive :generate
      end

      it "passes along any command-line arguments" do
        stub_const "ARGV", ["x", "y"]
        expect(@generator).to receive(:generate).with "rails:model", a_string_including("x y")
        @generator.invoke_all
      end

      it "disables test framework hooks" do
        expect(@generator).to receive(:generate).with "rails:model", a_string_ending_with("--no-test-framework")
        @generator.invoke_all
      end
    end

    describe "generating a basic model" do
      before do
        @generator = ModelGenerator.new(["my_widget"])
        allow(@generator).to receive :generate
        @generator.invoke_all
      end

      it "generates a factory" do
        expect(File.read "spec/factories/my_widget.rb").to include "factory :my_widget do"
      end

      it "generates a spec that describes the model class" do
        expect(File.read "spec/models/my_widget_spec.rb").to include "describe MyWidget do"
      end

      it "invokes the factory from the spec" do
        expect(File.read "spec/models/my_widget_spec.rb").to include "build :my_widget"
      end
    end

    describe "generating a namespaced model" do
      before do
        @generator = ModelGenerator.new(["admin/widget"])
        allow(@generator).to receive :generate
        @generator.invoke_all
      end

      it "uses the namespace when generating the factory" do
        expect(File.read "spec/factories/admin/widget.rb").to include "factory :admin_widget, class: Admin::Widget do"
      end

      it "uses the namespace when generating the spec" do
        expect(File.read "spec/models/admin/widget_spec.rb").to include "describe Admin::Widget do"
      end

      it "invokes the namespaced factory from the spec" do
        expect(File.read "spec/models/admin/widget_spec.rb").to include "build :admin_widget"
      end
    end
  end
end
