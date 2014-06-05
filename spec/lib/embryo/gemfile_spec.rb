require "embryo/gemfile"
require "tempfile"

module Embryo
  describe Gemfile do
    describe "#initialize" do
      it "allows a nonexistent file without errors" do
        Gemfile.new "bogus"
      end

      it "sets path to the given filename" do
        gemfile = Gemfile.new "my/file"
        expect(gemfile.path).to eq "my/file"
      end

      it "reads initial data from the given file" do
        tempfile = Tempfile.new "test"
        tempfile.write "hello world"
        tempfile.close
        gemfile = Gemfile.new tempfile.path
        expect(gemfile.data).to eq "hello world"
      end
    end

    describe ".current" do
      it "specifies Gemfile in the current directory" do
        expect(Gemfile.current.path).to eq "Gemfile"
      end
    end

    describe "#remove_noise" do
      before do
        @gemfile = Gemfile.new("bogus")
      end

      it "removes comment lines from the file data" do
        @gemfile.data = "#comment1\ncode1\n#comment2\ncode2\n#comment3"
        @gemfile.remove_noise
        expect(@gemfile.data).to eq "code1\ncode2\n"
      end

      it "collapses adjacent empty lines" do
        @gemfile.data = "code1\n#comment1\n\n\ncode2\ncode3\n\n\n\ncode4"
        @gemfile.remove_noise
        expect(@gemfile.data).to eq "code1\n\ncode2\ncode3\n\ncode4"
      end

      it "removes trailing empty lines" do
        @gemfile.data = "code1\n\n\n"
        @gemfile.remove_noise
        expect(@gemfile.data).to eq "code1\n"
      end
    end

    describe "#write" do
      it "delegates to create_file on the provided generator" do
        generator = double
        gemfile = Gemfile.new "myfile", generator: generator
        gemfile.data = "mydata"
        expect(generator).to receive(:create_file).with "myfile", "mydata", force: false
        gemfile.write
      end

      it "passes force:true to the create_file call if given" do
        generator = double
        gemfile = Gemfile.new "myfile", generator: generator
        gemfile.data = "mydata"
        expect(generator).to receive(:create_file).with "myfile", "mydata", force: true
        gemfile.write force: true
      end
    end
  end
end
