require "rails-embryo/generators/embryo/ruby_version"

module Embryo
  describe RubyVersionGenerator do
    around do |example|
      Dir.mktmpdir { |path| Dir.chdir(path, &example) }
    end

    around do |example|
      expect(&example).to output.to_stdout
    end

    describe "#invoke_all" do
      it "creates the correct ruby version file" do
        RubyVersionGenerator.new.invoke_all
        expect(File.read ".ruby-version").to eq "2.1.2\n"
      end

      it "creates the correct ruby gemset file" do
        RubyVersionGenerator.new.invoke_all
        expect(File.read ".ruby-gemset").to eq "#{File.basename Dir.pwd}\n"
      end
    end
  end
end
