require "rails-embryo"
require "tmpdir"

describe EmbryoGenerator do
  describe "#install" do
    it "rewrites Gemfile with comments and whitespace removed" do
      with_files "Gemfile" => "#test\ndata" do
        install_new_generator
        expect(File.read "Gemfile").not_to include "#test"
      end
    end

    it "adds required gems to the Gemfile" do
      with_files do
        install_new_generator
        expect(File.read "Gemfile").to include "rspec-rails"
        expect(File.read "Gemfile").to include "factory_girl_rails"
        expect(File.read "Gemfile").to include "capybara"
        expect(File.read "Gemfile").to include "launchy"
        expect(File.read "Gemfile").to include "haml-rails"
        expect(File.read "Gemfile").to include "bootstrap-sass"
        expect(File.read "Gemfile").to include "devise"
      end
    end

    it "creates required config files" do
      with_files do
        install_new_generator
        expect(File.exist? "spec/spec_helper.rb").to be_truthy
        expect(File.exist? "spec/rails_helper.rb").to be_truthy
        expect(File.exist? "spec/support/factory_girl.rb").to be_truthy
        expect(File.exist? "spec/support/capybara.rb").to be_truthy
        expect(File.exist? "spec/support/poltergeist.rb").to be_truthy
        expect(File.exist? "spec/support/devise.rb").to be_truthy
      end
    end

    it "creates the default dashboard controller" do
      with_files do
        install_new_generator
        expect(File.exist? "app/controllers/dashboard_controller.rb").to be_truthy
        expect(File.exist? "spec/controllers/dashboard_controller_spec.rb").to be_truthy
        expect(File.exist? "spec/features/dashboard_spec.rb").to be_truthy
      end
    end

    it "creates the haml layout" do
      with_files do
        install_new_generator
        expect(File.exist? "app/views/layouts/application.html.haml").to be_truthy
        expect(File.exist? "app/views/layouts/_navigation.html.haml").to be_truthy
        expect(File.exist? "app/views/layouts/_messages.html.haml").to be_truthy
      end
    end

    it "updates the assets" do
      with_files do
        install_new_generator
        expect(File.read "app/assets/javascripts/application.js").to include "bootstrap"
        expect(File.read "app/assets/stylesheets/bootstrap-custom.css.scss").to include "bootstrap"
      end
    end
  end

  def install_new_generator
    expect { EmbryoGenerator.new.install force: true, bundle: false }.to output.to_stdout
  end

  def with_files(files = {})
    defaults = {"Gemfile" => "", ".gitignore" => "", "config/environments/production.rb" => ""}
    Dir.mktmpdir do |path|
      Dir.chdir path do
        defaults.merge(files).each do |name, data|
          FileUtils.mkdir_p File.dirname(name)
          File.write name, data
        end
        yield
      end
    end
  end
end
