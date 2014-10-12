require "rails-embryo/version"
require "rails-embryo/generator_helpers/hidden"
require "rails-embryo/generator_helpers/files"
require "generators/embryo"
require "generators/embryo/controller"
require "generators/embryo/model"
require "generators/embryo/model/authenticated"
require "rails/railtie"

class EmbryoHiddenGeneratorsRailtie < Rails::Railtie
  config.app_generators do |generators|
    generators.hidden_namespaces.concat Embryo::GeneratorHelpers::Hidden.namespaces
  end
end
