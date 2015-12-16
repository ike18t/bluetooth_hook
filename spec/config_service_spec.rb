require_relative 'spec_helper'

describe ConfigService do
  describe '#get_address_maps' do
    it 'returns address maps for each address in config' do
      config = { 'address' => { 'in_endpoint' => 'in',
                                'in_request_verb' => 'post',
                                'in_request_payload' => 'payload',
                                'out_endpoint' => 'out',
                                'out_request_verb' => 'put',
                                'out_request_payload' => 'another payload',
                              } }
      allow(YAML).to receive(:load_file).and_return(config)

      address_maps = ConfigService.get_address_maps
      expect(address_maps[0].address).to eq('address')

      expect(address_maps[0].in.url).to eq('in')
      expect(address_maps[0].in.verb).to eq('post')
      expect(address_maps[0].in.payload).to eq('payload')

      expect(address_maps[0].out.url).to eq('out')
      expect(address_maps[0].out.verb).to eq('put')
      expect(address_maps[0].out.payload).to eq('another payload')
    end
  end
end
