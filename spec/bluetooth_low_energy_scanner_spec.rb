require_relative 'spec_helper'

describe BluetoothLowEnergyScanner do
  context '#detect' do
    before do
      stdout = double('stdout')

      allow(stdout).to receive(:read).and_return(File.read('spec/fixtures/lescan'))
      allow(Open3).to receive(:popen3).and_yield '', stdout, '', 1
      allow(BluetoothLowEnergyScanner).to receive(:kill_scan).and_return('')
    end

    context 'device is around' do
      it 'should return true for a valid address' do
        address = 'E0:05:BA:2D:06:6D'
        expect(BluetoothLowEnergyScanner.detect(address)).to be_truthy
      end
    end

    context 'device is not around' do
      it 'should return false for an invalid address' do
        address = 'BC:92:6B:43:DD:52'
        expect(BluetoothLowEnergyScanner.detect(address)).to be_falsy
      end
    end
  end
end
