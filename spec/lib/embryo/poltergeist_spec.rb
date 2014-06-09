require "embryo/test_support"

module Embryo
  describe Poltergeist do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds required gems to the test group" do
        expect(@filesystem).to receive(:require_gem).with "poltergeist", anything, hash_including(group: :test)
        Poltergeist.new(@filesystem).install
      end

      it "creates the required templates" do
        expect(@filesystem).to receive(:write).with "spec/support/poltergeist.rb", a_string_including(":poltergeist")
        Poltergeist.new(@filesystem).install
      end
    end
  end
end
