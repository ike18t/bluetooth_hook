require 'net/http'

class BluetoothHook
  def initialize
    @state = {}
    @scan_types = {}
  end

  def work
    ConfigService.get_address_maps.each do |address_map|
      detected = scan_for_device(address_map.address, @scan_types[address_map.address])
      next if @state[address_map.address] == detected
      @state[address_map.address] = detected
      endpoint = detected ? address_map.in : address_map.out
      call_endpoint(endpoint)
    end
  end

  private

  def scan_for_device(address, scan_type)
    return efficient_scan(address, scan_type) if scan_type
    bt_detected = BluetoothScanner.detect address
    btle_detected = BluetoothLowEnergyScanner.detect address
    @scan_types[address] = 'high' if bt_detected
    @scan_types[address] = 'low'  if btle_detected
    bt_detected || btle_detected
  end

  def call_endpoint endpoint
    puts "making request to #{endpoint.url}"
    RestClient::Request.execute(method: endpoint.verb,
                                url: endpoint.url,
                                payload: endpoint.payload)
  end

  def efficient_scan(address, scan_type)
    scan_type == 'high' ? BluetoothScanner.detect(address) : BluetoothLowEnergyScanner.detect(address)
  end
end
