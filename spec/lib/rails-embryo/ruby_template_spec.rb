require "rails-embryo/ruby_template"

module Embryo
  RSpec.describe RubyTemplate do
    before do
      @template = RubyTemplate.new
    end

    describe "#indent" do
      it "indents a string" do
        expect(@template.send :indent, "abc").to eq "  abc"
      end

      it "ignores empty lines" do
        expect(@template.send :indent, "").to eq ""
      end

      it "indents all strings in an array" do
        expect(@template.send :indent, ["abc", "", "def"]).to eq ["  abc", "", "  def"]
      end

      it "indents arbitrarily-nested arrays" do
        expect(@template.send :indent, ["abc", [["def"]]]).to eq ["  abc", [["  def"]]]
      end
    end

    describe "#indent_section" do
      it "converts a string to an array of empty line and indented line" do
        expect(@template.send :indent_section, "abc").to eq ["", "  abc"]
      end

      it "prefixes an array of strings with an empty line while indenting" do
        expect(@template.send :indent_section, ["abc", "", "def"]).to eq ["", "  abc", "", "  def"]
      end

      it "works on arbitrarily-nested arrays" do
        expect(@template.send :indent_section, ["abc", [["def"]]]).to eq ["", "  abc", [["  def"]]]
      end
    end

    describe "#indent_separated" do
      it "indents a string as normal" do
        expect(@template.send :indent, "abc").to eq "  abc"
      end

      it "inserts empty lines between components while indenting" do
        expect(@template.send :indent_separated, ["abc", "def"]).to eq ["  abc", "", "  def"]
      end

      it "works on arbitrarily-nested arrays, only separating the first level" do
        expect(@template.send :indent_separated, ["abc", [["def", "ghi"]]]).to eq ["  abc", "", [["  def", "  ghi"]]]
      end
    end
  end
end
