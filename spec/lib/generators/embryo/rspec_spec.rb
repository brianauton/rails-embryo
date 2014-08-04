require "generators/embryo/rspec"

module Embryo
  describe RspecGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch "Gemfile"
      end

      it "adds required gems to the test group" do
        RspecGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "rspec-rails"'
      end

      it "creates the required templates" do
        RspecGenerator.new.invoke_all
        expect(File.read "spec/spec_helper.rb").to include "RSpec.configure do"
        expect(File.read "spec/rails_helper.rb").to include "RSpec.configure do"
      end

      it "deletes any existing 'test' directory" do
        FileUtils.mkdir_p "test/units"
        RspecGenerator.new.invoke_all
        expect(File.exists? "test").to be_falsy
      end
    end
  end
end
