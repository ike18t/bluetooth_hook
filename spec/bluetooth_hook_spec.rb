require_relative 'spec_helper'

describe BluetoothHook do
  let(:address_map) { AddressMap.new("address", "in_url", "out_url") }

  before do
    allow(ConfigService).to receive(:get_address_maps).and_return([address_map])
  end

  it 'should call the in endpoint if bluetooth scanner detect returns true' do
    allow(BluetoothScanner).to receive(:detect).and_return true
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return false

    expect(RestClient).to receive(:put).with(address_map.in, '')

    BluetoothHook.new.work
  end

  it 'should call the in endpoint if bluetooth low energy scanner detect returns true' do
    allow(BluetoothScanner).to receive(:detect).and_return false
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return true

    expect(RestClient).to receive(:put).with(address_map.in, '')

    BluetoothHook.new.work
  end

  it 'should call the out endpoint if neither scanners detect the address' do
    allow(BluetoothScanner).to receive(:detect).and_return false
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return false

    expect(RestClient).to receive(:put).with(address_map.out, '')

    BluetoothHook.new.work
  end

  it "should call the out endpoint once if the state didn't change" do
    allow(BluetoothScanner).to receive(:detect).and_return false
    allow(BluetoothLowEnergyScanner).to receive(:detect).and_return false

    expect(RestClient).to receive(:put).with(address_map.out, '').once

    hook = BluetoothHook.new
    hook.work
    hook.work
  end
end
