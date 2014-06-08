require "embryo/test_support"

module Embryo
  describe TestSupport do
    describe "#install" do
      before do
        @required_gems = ["rspec-rails"]
      end

      it "adds all required gems to the given filesystem" do
        filesystem = double
        @required_gems.each do |gem_name|
          expect(filesystem).to receive(:require_gem).with gem_name, anything, anything
        end
        TestSupport.new(filesystem).install
      end

      it "adds testing gems to the test group" do
        filesystem = double
        @required_gems.each do |gem_name|
          expect(filesystem).to receive(:require_gem).with gem_name, anything, hash_including(group: :test)
        end
        TestSupport.new(filesystem).install
      end
    end
  end
end
