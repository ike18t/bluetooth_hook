require 'open3'

class BluetoothLowEnergyScanner
  extend Cachable

  class << self
    HCITOOL_LESCAN_CMD = 'sudo hcitool lescan'
    HCITOOL_KILL_CMD = 'sudo pkill --signal SIGINT hcitool'

    def detect(address)
      if cache_expired?
        Open3.popen3(HCITOOL_LESCAN_CMD) do |_, stdout, _, _|
          sleep 15
          kill_scan
          update_cache(stdout.read)
        end
      end
      get_cache.include?(address)
    end

    private

    def kill_scan
      `#{HCITOOL_KILL_CMD}`
    end
  end
end
