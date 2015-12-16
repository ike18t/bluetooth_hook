require 'open3'

class BluetoothLowEnergyScanner
  extend Cachable

  HCITOOL_LESCAN_CMD = 'sudo hcitool lescan'
  HCITOOL_KILL_CMD = 'sudo pkill --signal SIGINT hcitool'

  def self.detect(address)
    if scan_cache_expired?
      Open3.popen3(HCITOOL_LESCAN_CMD) do |stdin, stdout, stderr, wait_thr|
        sleep 15
        kill_scan
        update_cache(stdout.read)
      end
    end
    get_cache.include?(address)
  end

  private

  def self.kill_scan
    `#{HCITOOL_KILL_CMD}`
  end
end
