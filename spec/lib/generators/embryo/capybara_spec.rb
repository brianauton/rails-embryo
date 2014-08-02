require "generators/embryo/capybara"

module Embryo
  describe CapybaraGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch "Gemfile"
      end

      it "adds required gems to the test group" do
        CapybaraGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "capybara"'
        expect(File.read "Gemfile").to include 'gem "launchy"'
      end

      it "creates the required templates" do
        CapybaraGenerator.new.invoke_all
        expect(File.read "spec/support/capybara.rb").to include "Capybara::DSL"
      end
    end
  end
end
