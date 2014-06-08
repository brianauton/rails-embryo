require "embryo/test_support"

module Embryo
  describe TestSupport do
    describe "#install" do
      before do
        @required_gems = ["rspec-rails"]
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds all required gems to the given filesystem" do
        @required_gems.each do |gem_name|
          expect(@filesystem).to receive(:require_gem).with gem_name, anything, anything
        end
        TestSupport.new(@filesystem).install
      end

      it "adds testing gems to the test group" do
        @required_gems.each do |gem_name|
          expect(@filesystem).to receive(:require_gem).with gem_name, anything, hash_including(group: :test)
        end
        TestSupport.new(@filesystem).install
      end

      it "creates a spec_helper with appropriate content" do
        content = a_string_including "RSpec.configure do"
        expect(@filesystem).to receive(:write).with "spec/spec_helper.rb", content
        TestSupport.new(@filesystem).install
      end

      it "creates a rails_helper with appropriate content" do
        content = a_string_including "RSpec.configure do"
        expect(@filesystem).to receive(:write).with "spec/rails_helper.rb", content
        TestSupport.new(@filesystem).install
      end
    end
  end
end
