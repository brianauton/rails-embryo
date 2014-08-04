require "generators/embryo/model"

module Embryo
  describe ModelGenerator, :files, :stdout do
    before do
      @generator = ModelGenerator.new(["widget"])
      allow(@generator).to receive :generate
    end

    it "passes any command-line arguments to rails:model generator" do
      stub_const "ARGV", ["x", "y"]
      expect(@generator).to receive(:generate).with "rails:model", a_string_including("x y")
      @generator.invoke_all
    end

    it "disables test framework hooks in the rails:model generator" do
      expect(@generator).to receive(:generate).with "rails:model", a_string_ending_with("--no-test-framework")
      @generator.invoke_all
    end

    it "generats a factory" do
      @generator.invoke_all
      expect(File.read "spec/factories/widget.rb").to include "factory :widget"
    end

    it "generates a spec that builds the factory" do
      @generator.invoke_all
      expect(File.read "spec/models/widget_spec.rb").to include "build :widget"
    end
  end
end
