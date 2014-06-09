require "embryo/test_support"

module Embryo
  describe Rspec do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds required gems to the test group" do
        expect(@filesystem).to receive(:require_gem).with "rspec-rails", anything, hash_including(group: :test)
        Rspec.new(@filesystem).install
      end

      it "creates the required templates" do
        expect(@filesystem).to receive(:write).with "spec/spec_helper.rb", a_string_including("RSpec.configure do")
        expect(@filesystem).to receive(:write).with "spec/rails_helper.rb", a_string_including("RSpec.configure do")
        Rspec.new(@filesystem).install
      end
    end
  end
end
