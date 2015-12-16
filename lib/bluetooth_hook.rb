require 'net/http'

class BluetoothHook
  def initialize
    @state = {}
  end

  def work
    ConfigService.get_address_maps.each do |address_map|
      bt_detected = BluetoothScanner.detect address_map.address
      btle_detected = BluetoothLowEnergyScanner.detect address_map.address
      detected = bt_detected || btle_detected

      return if @state[address_map.address] == detected

      @state[address_map.address] = detected

      endpoint = detected ? address_map.in : address_map.out

      call_endpoint(endpoint)
    end
  end

  private

  def call_endpoint endpoint
    puts "making request to #{endpoint.url}"
    RestClient::Request.execute(method: endpoint.verb,
                                url: endpoint.url,
                                payload: endpoint.payload)
  end
end
