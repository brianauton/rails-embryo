require "embryo/test_support"

module Embryo
  describe TestSupport do
    describe "#install" do
      it "adds all required gems to the given gemfile" do
        gemfile = double
        expect(gemfile).to receive(:require_gem).with "rspec", anything, anything
        TestSupport.new(gemfile).install
      end

      it "adds testing gems to the test group" do
        gemfile = double
        expect(gemfile).to receive(:require_gem).with anything, anything, hash_including(group: :test)
        TestSupport.new(gemfile).install
      end
    end
  end
end
