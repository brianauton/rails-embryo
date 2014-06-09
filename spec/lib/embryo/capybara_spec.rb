require "embryo/test_support"

module Embryo
  describe Capybara do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds required gems to the test group" do
        expect(@filesystem).to receive(:require_gem).with "capybara", anything, hash_including(group: :test)
        expect(@filesystem).to receive(:require_gem).with "launchy", anything, hash_including(group: :test)
        Capybara.new(@filesystem).install
      end

      it "creates the required templates" do
        expect(@filesystem).to receive(:write).with "spec/support/capybara.rb", a_string_including("Capybara::DSL")
        Capybara.new(@filesystem).install
      end
    end
  end
end
