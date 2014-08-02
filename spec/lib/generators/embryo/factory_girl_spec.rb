require "generators/embryo/factory_girl"

module Embryo
  describe FactoryGirlGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch "Gemfile"
      end

      it "adds required gems to the test group" do
        FactoryGirlGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "factory_girl_rails"'
      end

      it "creates the required templates" do
        FactoryGirlGenerator.new.invoke_all
        expect(File.read "spec/support/factory_girl.rb").to include "FactoryGirl::Syntax::Methods"
      end
    end
  end
end
