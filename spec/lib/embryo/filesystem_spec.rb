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

    describe "#delete" do
      it "doesn't delete the file immediately" do
        generator = double
        filesystem = Filesystem.new generator
        expect(generator).not_to receive :remove_file
        filesystem.delete "myfile"
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

      it "removes any files deleted with #delete if they exist" do
        generator = double
        filesystem = Filesystem.new generator
        filesystem.delete "myfile"
        allow(File).to receive(:exist?).with("myfile") { true }
        expect(generator).to receive(:remove_file).with "myfile"
        filesystem.commit_changes
      end

      it "doesn't try to remove files that don't exist" do
        generator = double
        filesystem = Filesystem.new generator
        filesystem.delete "myfile"
        allow(File).to receive(:exist?).with("myfile") { false }
        expect(generator).not_to receive :remove_file
        filesystem.commit_changes
      end

      it "performs file operations in alphabetical order" do
        generator = double
        filesystem = Filesystem.new generator
        filesystem.write "bfile", "mydata"
        filesystem.delete "cfile"
        filesystem.write "afile", "mydata"
        allow(File).to receive(:exist?).with("cfile") { true }
        expect(generator).to receive(:create_file).with("afile", "mydata").ordered
        expect(generator).to receive(:create_file).with("bfile", "mydata").ordered
        expect(generator).to receive(:remove_file).with("cfile").ordered
        filesystem.commit_changes
      end
    end
  end
end
