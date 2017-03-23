class MoipClient
  attr_accessor :auth, :client, :api
  def initialize
    auth_params = YAML.load_file(Rails.root.join('config/moip.yml'))
    @auth = Moip2::Auth::Basic.new(auth_params['TOKEN'], auth_params['SECRET'])
    @client = Moip2::Client.new(:sandbox, @auth)
    @api = Moip2::Api.new(@client)
  end

  def create_order(data)
    order = api.order.create(data)
  end

  def create_payment(data)
    payment = api.order.create(data)
  end
end
