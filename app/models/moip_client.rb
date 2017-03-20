class MoipClient
  attr_accessor :auth, :client, :api
  def initialize
    auth_params = YAML.load_file(Rails.root.join('config/moip.yml'))
    @auth = Moip2::Auth::Basic.new(auth_params['TOKEN'], auth_params['SECRET'])
    @client = Moip2::Client.new(:sandbox, @auth)
    @api = Moip2::Api.new(@client)
  end

  def create_order(data)
    order = api.order.create({
      own_id: "ruby_sdk_1",
      items: [
        {
          product: "Nome do produto",
          quantity: 1,
          detail: "Mais info...",
          price: 1000
        }
      ],
      customer: {
        own_id: "ruby_sdk_customer_1",
        fullname: "Jose da Silva",
        email: "sandbox_v2_1401147277@email.com",
      }
    })
  end
end
