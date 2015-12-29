require 'yaml'

class ConfigService
  class << self
    def get_address_maps
      YAML::load_file(CONFIG_FILE)
    rescue Errno::ENOENT
      []
    end

    def add_address_map address_map
      address_maps = get_address_maps << address_map
      save! address_maps
    end

    def remove_address_map_by_name(name)
      address_maps = get_address_maps.reject{ |map| map.name == name }
      save! address_maps
    end

    private

    CONFIG_FILE = 'config.yml'

    def save! address_maps
      File.open(CONFIG_FILE, 'w+') do |f|
        f.write address_maps.to_yaml
      end
    end
  end
end
