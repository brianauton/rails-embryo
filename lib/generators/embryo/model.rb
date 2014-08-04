require "rails/generators"

module Embryo
  class ModelGenerator < Rails::Generators::NamedBase
    def install
      generate "rails:model", "#{ARGV.join ' '} --no-test-framework"
      create_file "spec/factories/#{singular_name}.rb", factory_data
      create_file "spec/models/#{singular_name}_spec.rb", spec_data
    end

    private

    def factory_data
'FactoryGirl.define do
  factory :' + singular_name + ' do
  end
end
'
    end

    def spec_data
'require "rails_helper"

describe ' + class_name + ' do
  it "initializes successfully" do
    expect(build :' + singular_name + ').to be_valid
  end
end
'
    end
  end
end
