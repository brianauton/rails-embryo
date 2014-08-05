require "generators/embryo/devise"

module Embryo
  describe DeviseGenerator, :files, :stdout do
    describe "#invoke_all" do
      before do
        FileUtils.touch "Gemfile"
      end

      it "adds required gems" do
        DeviseGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "devise"'
      end

      it "creates the required templates" do
        DeviseGenerator.new.invoke_all
        expect(File.read "spec/support/devise.rb").to include 'Devise::TestHelpers'
      end

      it "updates the development configuration" do
        FileUtils.mkdir_p "config/environments"
        File.write "config/environments/development.rb", "Rails.application.configure.do\nend\n"
        DeviseGenerator.new.invoke_all
        expect(File.read "config/environments/development.rb").to include 'action_mailer'
      end

      it "updates the test configuration" do
        FileUtils.mkdir_p "config/environments"
        File.write "config/environments/test.rb", "Rails.application.configure.do\nend\n"
        DeviseGenerator.new.invoke_all
        expect(File.read "config/environments/test.rb").to include 'action_mailer'
      end
    end
  end
end
