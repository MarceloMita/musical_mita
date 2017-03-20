class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def calculate_subtotal_value
    self.cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.subtotal
    end
  end

  def calculate_discount
    calculate_subtotal_value * 0.05
  end

  def calculate_total_value
    calculate_subtotal_value - calculate_discount
  end

  def quantity
    self.cart_items.inject(0) { |sum, cart_item| sum + cart_item.quantity }
  end

  def checkout_cart(data)
    moip_client = MoipClient.new
    order = moip_client.create_order(order_json(data[:customer_data]))
    payment = moip_client.create_payment(order.id, payment_json(data[:payment_data]))
  end

  protected

  def payment_json(payment_data)
    {
      installment_count: payment_data[:intallment_count],
      funding_instrument: 
    }
  end

  def order_json(customer_data)
    {
      own_id: generate_order_id,
      items: items_to_json,
      customer: customer_data
    }
  end

  def generate_order_id
    "pedido_#{self.created_at.to_i}_#{quantity}_#{calculate_subtotal_value.to_i}"
  end

  def items_to_json
    self.cart_items.includes(:product).map do |cart_item|
      {
        product: cart_item.product.title,
        quantity: cart_item.quantity,
        details: cart_item.product.description,
        price: cart_item.product.value
      }
    end
  end
end
