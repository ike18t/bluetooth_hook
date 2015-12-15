require_relative 'spec_helper'

describe ConfigService do
  describe '#get_address_maps' do
    it 'returns address maps for each address in config' do
      config = { 'address' => { 'in_endpoint' => 'in', 'out_endpoint' => 'out' } }
      allow(YAML).to receive(:load_file).and_return(config)

      address_maps = ConfigService.get_address_maps
      expect(address_maps[0].address).to eq('address')
      expect(address_maps[0].in).to eq('in')
      expect(address_maps[0].out).to eq('out')
    end
  end
end
