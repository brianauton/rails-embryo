require "rails/generators"

module Embryo
  class ModelGenerator < Rails::Generators::NamedBase
    def install
      generate "rails:model", "#{ARGV.join ' '} --no-test-framework"
      create_file "spec/factories/#{file_path}.rb", factory_data
      create_file "spec/models/#{file_path}_spec.rb", spec_data
    end

    private

    def factory_data
class_option = class_path.any? ? ", class: #{class_name}" : ""
'FactoryGirl.define do
  factory :' + factory_name + class_option + ' do
  end
end
'
    end

    def spec_data
'require "rails_helper"

describe ' + class_name + ' do
  it "initializes successfully" do
    expect(build :' + factory_name + ').to be_valid
  end
end
'
    end

    def factory_name
      file_path.gsub "/", "_"
    end
  end
end
