class Cart < ApplicationRecord
  belongs_to :client
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  enum status: %w(draft payment paid cancelled)

  def calculate_subtotal_value
    value = self.cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.subtotal
    end
  end

  def calculate_discount
    # 5% discount
    if Cupon.find_by(code: self.cupon).try(:valid_cupon?)
      calculate_subtotal_value * 0.05
    else
      0.0
    end
  end

  def calculate_additions
    # Addition of 2,5%
    if self.installment_count.nil?
      0.00
    else
      (self.installment_count.to_i > 1 ? calculate_total_value * 0.025 : 0)
    end
  end

  def calculate_total_value
    calculate_subtotal_value - calculate_discount
  end

  def calculate_total_price
    calculate_total_value + calculate_additions
  end

  def quantity
    self.cart_items.inject(0) { |sum, cart_item| sum + cart_item.quantity }
  end

  def checkout
    begin
      moip_client = MoipClient.new
      order = moip_client.create_order(order_json)
      payment = moip_client.create_payment(order.id, payment_json)
      if self.update(moip_order_id: order.id, moip_payment_id: payment.id, status: 1)
        return true
      else
        self.errors.add(:checked_out_error, message: "Couldn't checkout cart")
        return false
      end
    rescue => e
      self.errors.add(:checked_out_error, message: "Couldn't checkout cart")
      return false
    end
  end

  protected

  def payment_json
    {
      installment_count: self.installment_count,
      funding_instrument: {
        method: 'CREDIT_CARD',
        credit_card: self.client.credit_card.cc_to_json
      }
    }
  end

  def order_json
    {
      own_id: generate_order_id,
      amount: {
        currency: 'BRL',
        subtotals: {
          addition: (calculate_additions * 100).to_i,
          discount: (calculate_discount * 100).to_i
        }
      },
      items: items_to_json,
      customer: client_data_to_json
    }
  end

  def generate_order_id
    "pedido_#{self.created_at.to_i}_#{self.id}"
  end

  def items_to_json
    self.cart_items.includes(:product).map do |cart_item|
      {
        product: cart_item.product.title,
        quantity: cart_item.quantity,
        details: cart_item.product.description,
        price: (cart_item.product.value * 100).to_i
      }
    end
  end

  def client_data_to_json
    {
      own_id:    "cliente_musical_mita_#{self.client.id}",
      fullname: self.client.name,
      email:     self.client.email,
      birthdate: self.client.birthdate,
      tax_document: {
        number: self.client.cpf,
        type:   'CPF'
      },
      phone:            self.client.phone.phone_to_json,
      shipping_address: self.client.address.address_to_json
    }
  end
end
