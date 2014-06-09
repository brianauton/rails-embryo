require "embryo/template_support"

module Embryo
  describe TemplateSupport do
    describe "#install" do
      before do
        @filesystem = double require_gem: nil, write: nil
      end

      it "adds required gems" do
        expect(@filesystem).to receive(:require_gem).with "haml", anything
        expect(@filesystem).to receive(:require_gem).with "haml-rails", anything
        expect(@filesystem).to receive(:require_gem).with "bootstrap-sass", anything
        TemplateSupport.new(@filesystem).install
      end

      it "creates the required templates" do
        expect(@filesystem).to receive(:write).with "app/views/layouts/application.html.haml", a_string_including("%html")
        TemplateSupport.new(@filesystem).install
      end
    end
  end
end
