require 'yaml'

class ConfigService
  def self.get_address_maps
    config_hash = YAML::load_file(CONFIG_FILE)
    config_hash.each_with_object([]) do |(key, value), result|
      result << AddressMap.new(key, value['in_endpoint'], value['out_endpoint'])
    end
  end

  protected
  CONFIG_FILE = 'config.yml'
end
