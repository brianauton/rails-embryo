require "generators/embryo/poltergeist"

module Embryo
  describe PoltergeistGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch "Gemfile"
      end

      it "adds required gems to the test group" do
        PoltergeistGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "poltergeist"'
        expect(File.read "Gemfile").to include 'gem "database_cleaner"'
      end

      it "creates the poltergeist rspec configuration file" do
        PoltergeistGenerator.new.invoke_all
        expect(File.read "spec/support/poltergeist.rb").to include ':poltergeist'
      end

      it "creates the database_cleaner rspec configuration file" do
        PoltergeistGenerator.new.invoke_all
        expect(File.read "spec/support/database_cleaner.rb").to include ':truncation'
      end
    end
  end
end
