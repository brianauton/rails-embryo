require "rails-embryo"

describe EmbryoGenerator do
  describe "#install" do
    it "rewrites Gemfile with comments and whitespace removed" do
      Dir.mktmpdir do |path|
        Dir.chdir path do
          File.write "Gemfile", "#test\ndata"
          expect do
            EmbryoGenerator.new.install force: true
          end.to output(anything).to_stdout
          expect(File.read "Gemfile").to eq "data"
        end
      end
    end
  end
end
