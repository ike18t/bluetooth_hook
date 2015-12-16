class BluetoothWeb < Sinatra::Base
  set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
  set :bind, '0.0.0.0'

  get '/devices' do
    address_maps = ConfigService.get_address_maps
    haml :index, locals: { address_maps: address_maps }
  end

  get '/devices/add' do
    haml :add
  end

  post '/devices/add' do
    address_map = AddressMap.new(params)
    ConfigService.add_address_map(address_map)
    redirect '/devices'
  end

  get '/devices/remove/:address' do
    ConfigService.remove_address_map_by_address(params[:address])
    redirect '/devices'
  end
end
