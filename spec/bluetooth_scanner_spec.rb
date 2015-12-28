require_relative 'spec_helper'

describe BluetoothScanner do
  context '#detect' do
    context 'device is around' do
      before do
        wait_thr = double('wait_thr')
        wait_thr_value = double('wait_thr_value')

        allow(wait_thr_value).to receive(:success?).and_return(true)
        allow(wait_thr).to receive(:value).and_return(wait_thr_value)
        allow(Open3).to receive(:popen3).and_yield('', '', '', wait_thr)
      end

      it 'should return true for a valid address' do
        address = 'BC:92:6B:43:DD:51'
        expect(BluetoothScanner.detect(address)).to be_truthy
      end
    end

    context 'device is not around' do
      before do
        wait_thr = double('wait_thr')
        wait_thr_value = double('wait_thr_value')

        allow(wait_thr_value).to receive(:success?).and_return(false)
        allow(wait_thr).to receive(:value).and_return(wait_thr_value)
        allow(Open3).to receive(:popen3).and_yield('', '', '', wait_thr)
      end

      it 'should return false for an invalid address' do
        address = 'BC:92:6B:43:DD:52'
        expect(BluetoothScanner.detect(address)).to be_falsy
      end
    end
  end
end
