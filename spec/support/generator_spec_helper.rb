RSpec.configure do |config|
  config.around :example, :files do |example|
    Dir.mktmpdir { |path| Dir.chdir(path, &example) }
  end

  config.around :example, :stdout do |example|
    expect(&example).to output.to_stdout
  end
end
