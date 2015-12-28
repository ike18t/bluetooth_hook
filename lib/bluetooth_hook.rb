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
    return scan_type.detect(address) if scan_type
    [BluetoothScanner, BluetoothLowEnergyScanner].inject(false) do |detected, scanner|
      detected = scanner.detect address
      next detected if not detected
      @scan_types[address] = scanner
      return detected if detected
    end
  end

  def call_endpoint endpoint
    puts "making request to #{endpoint.url}"
    begin
      RestClient::Request.execute(method: endpoint.verb,
                                  url: endpoint.url,
                                  payload: endpoint.payload)
    rescue => e
      puts e.response
    end
  end
end
