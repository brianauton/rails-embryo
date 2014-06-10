require "embryo/ruby_version"

module Embryo
  describe RubyVersion do
    describe "#install" do
      before do
        @filesystem = double write: nil, application_name: "myapp"
      end

      it "creates the correct ruby version file" do
        expect(@filesystem).to receive(:write).with ".ruby-version", "2.1.2\n"
        RubyVersion.new(@filesystem).install
      end

      it "creates the correct ruby gemset file" do
        expect(@filesystem).to receive(:write).with ".ruby-gemset", "myapp\n"
        RubyVersion.new(@filesystem).install
      end
    end
  end
end
