require "generators/embryo/model"

module Embryo
  module Model
    describe AuthenticatedGenerator, :files, :stdout do
      before do
        FileUtils.mkdir_p "app/controllers"
        FileUtils.touch "app/controllers/application_controller.rb"
        FileUtils.touch "app/controllers/dashboard_controller.rb"
        FileUtils.mkdir_p "spec/factories"
        FileUtils.touch "spec/factories/widget.rb"
        FileUtils.mkdir_p "db"
        FileUtils.touch "db/seeds.rb"
        @generator = AuthenticatedGenerator.new(["widget"])
        allow(@generator).to receive :generate
      end

      describe "invoking embryo:model generator" do
        it "passes along any command-line arguments" do
          stub_const "ARGV", ["x", "y"]
          expect(@generator).to receive(:generate).with "embryo:model", a_string_including("x y")
          @generator.invoke_all
        end
      end

      describe "invoking devise:install generator" do
        it "invokes with the quiet option if initializer doesn't exist" do
          expect(@generator).to receive(:generate).with "devise:install --quiet"
          @generator.invoke_all
        end

        it "skips if initializer already exists" do
          FileUtils.mkdir_p "config/initializers"
          FileUtils.touch "config/initializers/devise.rb"
          expect(@generator).not_to receive(:generate).with a_string_including("devise:install")
          @generator.invoke_all
        end
      end

      describe "invoking devise model generator" do
        it "passes along the model name" do
          stub_const "ARGV", ["my_widget"]
          expect(@generator).to receive(:generate).with "devise my_widget"
          @generator.invoke_all
        end
      end
    end
  end
end
