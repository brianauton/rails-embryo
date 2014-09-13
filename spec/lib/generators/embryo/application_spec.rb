require "generators/embryo/application"

module Embryo
  describe ApplicationGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch ".gitignore"
        FileUtils.mkdir_p "config/environments"
        FileUtils.touch "config/environments/production.rb"
      end

      it "generates secrets.yml" do
        ApplicationGenerator.new.invoke_all
        expect(File.read "config/secrets.yml").to include 'secret_key_base:'
      end

      it "generates secrets.yml.example" do
        ApplicationGenerator.new.invoke_all
        expect(File.read "config/secrets.yml.example").to include 'secret_key_base:'
      end

      it "adds secrets.yml to .gitignore" do
        ApplicationGenerator.new.invoke_all
        expect(File.read ".gitignore").to include 'secrets.yml'
      end

      it "copies production config to staging" do
        File.write "config/environments/production.rb", "TESTING"
        ApplicationGenerator.new.invoke_all
        expect(File.read "config/environments/staging.rb").to eq "TESTING"
      end
    end
  end
end
