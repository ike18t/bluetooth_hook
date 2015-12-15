require 'open3'

class BluetoothLowEnergyScanner
  HCITOOL_LESCAN_CMD = 'sudo hcitool lescan'

  def self.detect(address)
    stdout = Open3.popen3(HCITOOL_LESCAN_CMD)[1]
    return stdout.gets.include?(address)
  end
end
