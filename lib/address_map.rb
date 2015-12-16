class AddressMap

  attr_reader :address, :in, :out

  def initialize(param_hash)
    @address = param_hash['address']

    @in = Endpoint.new(param_hash['in_endpoint'],
                       param_hash['in_request_verb'],
                       param_hash['in_request_payload'])

    @out = Endpoint.new(param_hash['out_endpoint'],
                        param_hash['out_request_verb'],
                        param_hash['out_request_payload'])
  end
end
