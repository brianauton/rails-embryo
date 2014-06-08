require "embryo/filesystem"
require "embryo/gemfile"

module Embryo
  describe Filesystem do
    describe "#require_gem" do
      it "delegates to a current gemfile created with the given generator" do
        gemfile, generator = double, double
        expect(Gemfile).to receive(:current).with(generator: generator) { gemfile }
        expect(gemfile).to receive(:require_gem).with "mygem", "myversion", myoption: :myvalue
        Filesystem.new(generator).require_gem "mygem", "myversion", myoption: :myvalue
      end

      it "passes multiple calls to the same gemfile" do
        gemfile = double
        expect(Gemfile).to receive(:current) { gemfile }
        expect(gemfile).to receive(:require_gem).with "gem1", "0"
        expect(gemfile).to receive(:require_gem).with "gem2", "0"
        filesystem = Filesystem.new double
        filesystem.require_gem "gem1", "0"
        filesystem.require_gem "gem2", "0"
      end
    end

    describe "#commit_changes" do
      it "writes the gemfile" do
        gemfile = double
        expect(Gemfile).to receive(:current) { gemfile }
        expect(gemfile).to receive(:write)
        Filesystem.new(double).commit_changes
      end
    end
  end
end
