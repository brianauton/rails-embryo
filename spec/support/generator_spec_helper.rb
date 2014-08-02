module GeneratorSpecHelper
  def use_temp_dir
    around do |example|
      Dir.mktmpdir { |path| Dir.chdir(path, &example) }
    end
  end

  def suppress_stdout
    around do |example|
      expect(&example).to output.to_stdout
    end
  end
end

RSpec.configure do |config|
  config.extend GeneratorSpecHelper
end
