require "generators/embryo/postgres"

module Embryo
  describe PostgresGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch "Gemfile"
      end

      it "adds required gems" do
        PostgresGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "pg"'
      end

      it "generates database.yml" do
        PostgresGenerator.new.invoke_all
        expect(File.read "config/database.yml").to include 'database: unknown'
      end

      it "generates database.yml.example" do
        PostgresGenerator.new.invoke_all
        expect(File.read "config/database.yml.example").to include 'database: unknown'
      end

      it "adds database.yml to .gitignore" do
        PostgresGenerator.new.invoke_all
        expect(File.read ".gitignore").to include 'database.yml'
      end
    end
  end
end
