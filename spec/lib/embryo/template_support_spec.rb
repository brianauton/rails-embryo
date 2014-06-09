require "embryo/template_support"

module Embryo
  describe TemplateSupport do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil, delete: nil
      end

      it "adds required gems" do
        expect(@filesystem).to receive(:require_gem).with "haml", anything
        expect(@filesystem).to receive(:require_gem).with "haml-rails", anything
        expect(@filesystem).to receive(:require_gem).with "bootstrap-sass", anything
        TemplateSupport.new(@filesystem).install
      end

      it "creates the required templates" do
        expect(@filesystem).to receive(:write).with "app/views/layouts/application.html.haml", a_string_including("%html")
        expect(@filesystem).to receive(:write).with "app/views/layouts/_navigation.html.haml", a_string_including("%ul.nav.navbar-nav")
        expect(@filesystem).to receive(:write).with "app/views/layouts/_messages.html.haml", a_string_including(".alert")
        TemplateSupport.new(@filesystem).install
      end

      it "deletes the correct files" do
        expect(@filesystem).to receive(:delete).with "app/views/layouts/application.html.erb"
        TemplateSupport.new(@filesystem).install
      end
    end
  end
end
