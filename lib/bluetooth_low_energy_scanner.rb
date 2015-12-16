require 'open3'

class BluetoothLowEnergyScanner
  HCITOOL_LESCAN_CMD = 'sudo hcitool lescan'
  HCITOOL_KILL_CMD = 'sudo pkill --signal SIGINT hcitool'

  def self.detect(address)
    Open3.popen3(HCITOOL_LESCAN_CMD) do |stdin, stdout, stderr, wait_thr|
      sleep 4
      `#{HCITOOL_KILL_CMD}`
      return stdout.read.include?(address)
    end
  end
end
