require "rails-embryo"

describe EmbryoGenerator do
  describe "#install" do
    it "rewrites Gemfile with comments and whitespace removed" do
      with_files "Gemfile" => "#test\ndata" do
        expect { EmbryoGenerator.new.install force: true }.to output.to_stdout
        expect(File.read "Gemfile").not_to include "#test"
      end
    end

    it "adds rspec to the Gemfile" do
      with_files do
        expect { EmbryoGenerator.new.install force: true }.to output.to_stdout
        expect(File.read "Gemfile").to include "rspec"
      end
    end
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
