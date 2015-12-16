require 'yaml'

class ConfigService
  def self.get_address_maps
    YAML::load_file(CONFIG_FILE)
  rescue Errno::ENOENT
    []
  end

  def self.add_address_map address_map
    address_maps = get_address_maps << address_map
    save! address_maps
  end

  def self.remove_address_map_by_address(address)
    address_maps = get_address_maps.reject{ |map| map.address == address }
    save! address_maps
  end

  private

  CONFIG_FILE = 'config.yml'

  def self.save! address_maps
    File.open(CONFIG_FILE, 'w+') do |f|
      f.write address_maps.to_yaml
    end
  end
end
