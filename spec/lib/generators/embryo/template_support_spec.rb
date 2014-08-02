require "generators/embryo/template_support"

module Embryo
  describe TemplateSupportGenerator, :files, :stdout do
    before do
      FileUtils.touch "Gemfile"
    end

    describe "#invoke_all" do
      it "adds required gems" do
        TemplateSupportGenerator.new.invoke_all
        expect(File.read "Gemfile").to include 'gem "haml"'
        expect(File.read "Gemfile").to include 'gem "haml-rails"'
        expect(File.read "Gemfile").to include 'gem "bootstrap-sass"'
      end

      it "creates the required templates" do
        TemplateSupportGenerator.new.invoke_all
        expect(File.read "app/views/layouts/application.html.haml").to include "%html"
        expect(File.read "app/views/layouts/_navigation.html.haml").to include "%ul.nav.navbar-nav"
        expect(File.read "app/views/layouts/_messages.html.haml").to include ".alert"
        expect(File.read "app/assets/javascripts/application.js").to include "require bootstrap"
        expect(File.read "app/assets/stylesheets/bootstrap-custom.css.scss").to include "import \"bootstrap\""
      end

      it "deletes the correct files" do
        FileUtils.mkdir_p "app/views/layouts"
        FileUtils.touch "app/views/layouts/application.html.erb"
        TemplateSupportGenerator.new.invoke_all
        expect(File.exists? "app/views/layouts/application.html.erb").to be_falsy
      end
    end
  end
end
