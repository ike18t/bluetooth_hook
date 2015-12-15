require 'open3'

class BluetoothScanner
  HCITOOL_INFO_CMD = 'sudo hcitool info %s'

  def self.detect(address)
    stderr = Open3.popen3(HCITOOL_INFO_CMD % address)[2]
    return stderr.gets.empty?
  end
end
