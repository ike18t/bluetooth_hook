describe 'Bluetooth Web' do
  include Rack::Test::Methods

  def app
    BluetoothWeb
  end

  describe 'home' do
    it 'redirects to devices' do
      get '/'
      expect(last_response).to be_redirect
      expect(last_response.location).to end_with '/devices'
    end
  end

  describe 'getting devices' do
    it 'returns a successful request' do
      get '/devices'
      expect(last_response).to be_ok
    end
  end

  describe 'adding devices' do
    describe 'adding page' do
      it 'returns a successful request' do
        get '/devices/add'
        expect(last_response).to be_ok
      end
    end

    describe 'adding a device' do
      it 'redirects to devices' do
        post '/devices/add'
        expect(last_response).to be_redirect
        expect(last_response.location).to end_with '/devices'
      end
    end
  end

  describe 'removing a device' do
    it 'redirects to devices' do
      get '/devices/remove/1'
      expect(last_response).to be_redirect
      expect(last_response.location).to end_with '/devices'
    end
  end
end
