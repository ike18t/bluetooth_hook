require 'open3'

class BluetoothScanner
  HCITOOL_INFO_CMD = 'sudo hcitool info %s | grep \'Device Name\''

  def self.detect(address)
    Open3.popen3(HCITOOL_INFO_CMD % address) do |_, _, _, wait_thr|
      wait_thr.value.success?
    end
  end
end
