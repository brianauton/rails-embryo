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

    describe "#require_gem" do
      it "delegates to gemfile" do
        gemfile = double
        filesystem = Filesystem.new(double)
        allow(filesystem).to receive(:gemfile) { gemfile }
        expect(gemfile).to receive(:require_gem).with "myargs"
        filesystem.require_gem "myargs"
      end
    end

    describe "#write" do
      it "doesn't write the file immediately" do
        generator = double
        filesystem = Filesystem.new generator
        expect(generator).not_to receive :create_file
        filesystem.write "myfile", "mydata"
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

      it "commits any files written with #write" do
        generator = double
        filesystem = Filesystem.new generator
        filesystem.write "myfile", "mydata"
        expect(generator).to receive(:create_file).with "myfile", "mydata"
        filesystem.commit_changes
      end
    end
  end
end