require "embryo/filesystem"

module Embryo
  describe Filesystem do
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

    describe "application_name" do
      it "uses the name of the current directory" do
        in_directory_named "part1/part2" do
          filesystem = Filesystem.new double
          expect(filesystem.application_name).to eq "part2"
        end
      end
    end

    describe "application_human_name" do
      it "uses the humanized name of the current directory" do
        in_directory_named "part1/multi_part_name" do
          filesystem = Filesystem.new double
          expect(filesystem.application_human_name).to eq "Multi Part Name"
        end
      end
    end

    def in_directory_named(name, &block)
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p "dir/#{name}"
        Dir.chdir "dir/#{name}", &block
      end
    end
  end
end
