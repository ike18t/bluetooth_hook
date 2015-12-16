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
    expect(RestClient::Request).to receive(:execute).with(expected_param_hash)

    hook = BluetoothHook.new
    hook.work
    hook.work
  end
end
