require "rails-embryo/ruby_template/model"

class Embryo::RubyTemplate
  RSpec.describe Model do
    it "generates the correct singular path name" do
      expect(Model.new("orange").path).to eq "orange"
      expect(Model.new("name/spaced/orange").path).to eq "name/spaced/orange"
    end

    it "generates the correct plural path name" do
      expect(Model.new("orange").plural_path).to eq "oranges"
      expect(Model.new("name/spaced/orange").plural_path).to eq "name/spaced/oranges"
      expect(Model.new("name/spaced/lily").plural_path).to eq "name/spaced/lilies"
    end

    it "generates the correct singular name" do
      expect(Model.new("orange").singular).to eq "orange"
      expect(Model.new("name/spaced/orange").singular).to eq "orange"
    end

    it "generates the correct plural name" do
      expect(Model.new("orange").plural).to eq "oranges"
      expect(Model.new("name/spaced/orange").plural).to eq "oranges"
      expect(Model.new("name/spaced/lily").plural).to eq "lilies"
    end

    it "generates the correct singular class name" do
      expect(Model.new("orange").class_name).to eq "Orange"
      expect(Model.new("name/spaced/orange").class_name).to eq "Name::Spaced::Orange"
    end

    it "generates the correct plural class name" do
      expect(Model.new("orange").plural_class_name).to eq "Oranges"
      expect(Model.new("name/spaced/orange").plural_class_name).to eq "Name::Spaced::Oranges"
      expect(Model.new("name/spaced/lily").plural_class_name).to eq "Name::Spaced::Lilies"
    end
  end
end
