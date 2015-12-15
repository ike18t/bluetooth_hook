require_relative 'spec_helper'

describe BluetoothScanner do
  context '#detect' do
    context 'device is around' do
      before do
        stderr = double('stderr')

        allow(stderr).to receive(:gets).and_return(nil)
        allow(Open3).to receive(:popen3).and_return([nil, nil, stderr])
      end

      it 'should return true for a valid address' do
        address = 'BC:92:6B:43:DD:51'
        expect(BluetoothScanner.detect(address)).to be_truthy
      end
    end

    context 'device is not around' do
      before do
        stderr = double('stderr')

        allow(stderr).to receive(:gets).and_return(File.read('spec/fixtures/unsuccessful_info_stderr'))
        allow(Open3).to receive(:popen3).and_return([nil, nil, stderr])
      end

      it 'should return false for an invalid address' do
        address = 'BC:92:6B:43:DD:52'
        expect(BluetoothScanner.detect(address)).to be_falsy
      end
    end
  end
end
