require "embryo/rspec"

module Embryo
  describe Rspec do
    describe "#install" do
      it "adds rspec to the given gemfile" do
        gemfile = double
        expect(gemfile).to receive(:require_gem).with "rspec", anything, anything
        Rspec.new(gemfile).install
      end

      it "adds rspec gem to the test group" do
        gemfile = double
        expect(gemfile).to receive(:require_gem).with anything, anything, hash_including(group: :test)
        Rspec.new(gemfile).install
      end
    end
  end
end
