require "embryo/rspec"

module Embryo
  describe Rspec do
    describe "#install" do
      it "adds rspec to the given gemfile" do
        gemfile = double
        expect(gemfile).to receive(:require_gem).with "rspec", anything
        Rspec.new(gemfile).install
      end
    end
  end
end
