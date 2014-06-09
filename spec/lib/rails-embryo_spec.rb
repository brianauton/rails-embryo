require "rails-embryo"
require "tmpdir"

describe EmbryoGenerator do
  describe "#install" do
    it "rewrites Gemfile with comments and whitespace removed" do
      with_files "Gemfile" => "#test\ndata" do
        install_new_generator
        expect { EmbryoGenerator.new.install force: true }.to output.to_stdout
        expect(File.read "Gemfile").not_to include "#test"
      end
    end

    it "adds required gems to the Gemfile" do
      with_files do
        install_new_generator
        expect { EmbryoGenerator.new.install force: true }.to output.to_stdout
        expect(File.read "Gemfile").to include "rspec-rails"
        expect(File.read "Gemfile").to include "factory_girl_rails"
        expect(File.read "Gemfile").to include "capybara"
        expect(File.read "Gemfile").to include "launchy"
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
  end

  def install_new_generator
    expect { EmbryoGenerator.new.install force: true }.to output.to_stdout
  end

  def with_files(files = {})
    Dir.mktmpdir do |path|
      Dir.chdir path do
        files.each { |name, data| File.write name, data }
        yield
      end
    end
  end
end
