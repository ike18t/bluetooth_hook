require_relative 'spec_helper'

describe BluetoothHook do
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
  let(:address_map2) { AddressMap.new(config.merge('address' => 'other', 'out_endpoint' => 'other_in')) }

  before do
    allow(ConfigService).to receive(:get_address_maps).and_return([address_map])
  end

  it 'should call the in endpoint if bluetooth scanner detect returns true' do
    allow(BluetoothScanner).to receive(:detect).and_return true
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return false

    expected_param_hash = { method: address_map.in.verb,
                            url: address_map.in.url,
                            payload: address_map.in.payload }
    expect(RestClient::Request).to receive(:execute).with(expected_param_hash)

    BluetoothHook.new.work
  end

  it 'should call the in endpoint if bluetooth low energy scanner detect returns true' do
    allow(BluetoothScanner).to receive(:detect).and_return false
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return true

    expected_param_hash = { method: address_map.in.verb,
                            url: address_map.in.url,
                            payload: address_map.in.payload }
    expect(RestClient::Request).to receive(:execute).with(expected_param_hash)

    BluetoothHook.new.work
  end

  it 'should call the out endpoint if neither scanners detect the address' do
    allow(BluetoothScanner).to receive(:detect).and_return false
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return false

    expected_param_hash = { method: address_map.out.verb,
                            url: address_map.out.url,
                            payload: address_map.out.payload }
    expect(RestClient::Request).to receive(:execute).with(expected_param_hash)

    BluetoothHook.new.work
  end

  it "should call the out endpoint once if the state didn't change" do
    allow(BluetoothScanner).to receive(:detect).and_return false
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return false

    expected_param_hash = { method: address_map.out.verb,
                            url: address_map.out.url,
                            payload: address_map.out.payload }
    expect(RestClient::Request).to receive(:execute).with(expected_param_hash).once

    hook = BluetoothHook.new
    hook.work
    hook.work
  end

  it "should loop over all addresses" do
    allow(ConfigService).to receive(:get_address_maps).and_return([address_map, address_map2])

    allow(BluetoothScanner).to receive(:detect).with(address_map.address).and_return(false, false)
    allow(BluetoothScanner).to receive(:detect).with(address_map2.address).and_return(false, true)
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return(false)

    expected_param_hash = { method: address_map.out.verb,
                            url: address_map.out.url,
                            payload: address_map.out.payload }
    other_expected_param_hash_out = { method: address_map2.out.verb,
                                      url: address_map2.out.url,
                                      payload: address_map2.out.payload }
    other_expected_param_hash_in = { method: address_map2.in.verb,
                                      url: address_map2.in.url,
                                      payload: address_map2.in.payload }
    expect(RestClient::Request).to receive(:execute).with(expected_param_hash).once
    expect(RestClient::Request).to receive(:execute).with(other_expected_param_hash_out).once
    expect(RestClient::Request).to receive(:execute).with(other_expected_param_hash_in).once

    hook = BluetoothHook.new
    hook.work
    hook.work
  end
end
