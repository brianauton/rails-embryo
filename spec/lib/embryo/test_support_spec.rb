require "embryo/test_support"

module Embryo
  describe TestSupport do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds all required gems to the given filesystem" do
        required_gems.each do |gem_name|
          expect(@filesystem).to receive(:require_gem).with gem_name, anything, anything
        end
        TestSupport.new(@filesystem).install
      end

      it "adds testing gems to the test group" do
        required_gems.each do |gem_name|
          expect(@filesystem).to receive(:require_gem).with gem_name, anything, hash_including(group: :test)
        end
        TestSupport.new(@filesystem).install
      end

      it "creates required files" do
        required_files.each do |name|
          expect(@filesystem).to receive(:write).with name, anything
        end
        TestSupport.new(@filesystem).install
      end

      def required_gems
        ["rspec-rails", "factory_girl_rails", "capybara", "launchy", "poltergeist"]
      end

      def required_files
        ["spec/spec_helper.rb", "spec/rails_helper.rb", "spec/support/factory_girl.rb",
         "spec/support/capybara.rb", "spec/support/poltergeist.rb"]
      end
    end
  end
end
