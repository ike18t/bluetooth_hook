describe 'Bluetooth Web' do
  include Rack::Test::Methods
  # include Mocha::API

  def app
    BluetoothWeb
  end

  describe 'home' do
    it 'redirects to devices' do
      get '/'
      last_response.should be_redirect
      last_response.location.should end_with '/devices'
    end
  end

  describe 'getting devices' do
    it 'returns a successful request' do
      get '/devices'
      expect(last_response.status).to eq(200)
    end
  end

  describe 'adding devices' do
    describe 'adding page' do
      it 'returns a successful request' do
        get '/devices/add'
        expect(last_response.status).to eq(200)
      end
    end

    describe 'adding a device' do
      it 'redirects to devices' do
        post '/devices/add'
        last_response.should be_redirect
        last_response.location.should end_with '/devices'
      end
    end
  end

  describe 'removing a device' do
    it 'redirects to devices' do
      get '/devices/remove/1'
      last_response.should be_redirect
      last_response.location.should end_with '/devices'
    end
  end
end