require "embryo/test_support"

module Embryo
  describe FactoryGirl do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds required gems to the test group" do
        expect(@filesystem).to receive(:require_gem).with "factory_girl_rails", anything, hash_including(group: :test)
        FactoryGirl.new(@filesystem).install
      end

      it "creates the required templates" do
        expect(@filesystem).to receive(:write).with "spec/support/factory_girl.rb", a_string_including("FactoryGirl::Syntax::Methods")
        FactoryGirl.new(@filesystem).install
      end
    end
  end
end
