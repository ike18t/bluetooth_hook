require_relative 'spec_helper'

describe ConfigService do
  describe '#add_address_map' do
    let(:config) {
      { 'address' => 'address',
        'in_endpoint' => 'in',
        'in_request_verb' => 'POST',
        'in_request_payload' => 'payload',
        'out_endpoint' => 'out',
        'out_request_verb' => 'PUT',
        'out_request_payload' => 'another payload',
      }
    }

    let(:address_map) { AddressMap.new(config) }

    it 'should add an address map' do
      expect(ConfigService).to receive(:get_address_maps).and_return([address_map])
      new_address = AddressMap.new(config.merge('address' => 'not the same'))
      address_maps = [address_map, new_address]
      expect(ConfigService).to receive(:save!).with(address_maps)
      ConfigService.add_address_map(new_address)
    end

    it 'should remove an address map by name' do
      expect(ConfigService).to receive(:get_address_maps).and_return([address_map])
      expect(ConfigService).to receive(:save!).with([])
      ConfigService.remove_address_map_by_name(address_map.name)
    end
  end
end
