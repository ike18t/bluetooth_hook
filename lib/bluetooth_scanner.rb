require 'open3'

class BluetoothScanner
  HCITOOL_INFO_CMD = 'sudo hcitool info %s'

  def self.detect(address)
    Open3.popen3(HCITOOL_INFO_CMD % address) do |stdin, stdout, stderr, wait_thr|
      wait_thr.value.success?
    end
  end
end
