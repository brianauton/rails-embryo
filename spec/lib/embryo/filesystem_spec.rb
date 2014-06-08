require "embryo/filesystem"
require "embryo/gemfile"

module Embryo
  describe Filesystem do
    describe "#gemfile" do
      before do
        @gemfile, @generator = double, double
        expect(Gemfile).to receive(:current).with(generator: @generator) { @gemfile }
      end

      it "returns a current gemfile created with the given generator" do
        expect(Filesystem.new(@generator).gemfile).to eq @gemfile
      end

      it "returns the same gemfile object from multiple calls" do
        filesystem = Filesystem.new @generator
        expect(filesystem.gemfile).to eq @gemfile
        expect(filesystem.gemfile).to eq @gemfile
      end
    end

    describe "#commit_changes" do
      before do
        @gemfile = double
        allow(Gemfile).to receive(:current) { @gemfile }
      end

      it "writes the gemfile" do
        filesystem = Filesystem.new double
        expect(@gemfile).to receive(:write)
        filesystem.gemfile
        filesystem.commit_changes
      end

      it "passes along any write_options received" do
        filesystem = Filesystem.new double, force: true
        expect(@gemfile).to receive(:write).with force: true
        filesystem.gemfile
        filesystem.commit_changes
      end
    end
  end
end
