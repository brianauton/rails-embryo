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
      end

      it "creates the required templates" do
        PoltergeistGenerator.new.invoke_all
        expect(File.read "spec/support/poltergeist.rb").to include ':poltergeist'
      end
    end
  end
end
