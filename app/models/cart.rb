class Cart < ApplicationRecord
  belongs_to :client
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def calculate_subtotal_value
    value = self.cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.subtotal
    end
    value * 100 # Get value in cents
  end

  def calculate_discount
    # 5% discount * 100 to get value in cents
    calculate_subtotal_value * 0.05 * 100
  end

  def calculate_additions(installments)
    # Addition of 2,5% * 100 to get value in cents
    (installments > 1 ? calculate_total_value * 0.025 : 0) * 100
  end

  def calculate_total_value
    calculate_subtotal_value - calculate_discount
  end

  def quantity
    self.cart_items.inject(0) { |sum, cart_item| sum + cart_item.quantity }
  end

  def checkout(data)
    moip_client = MoipClient.new
    order = moip_client.create_order(order_json(data[:payment_data][:installment_count]))
    payment = moip_client.create_payment(order.id, payment_json(data[:payment_data]))

    if self.update(moip_order_id: order.id, moip_payment_id: payment.id, checked_out: true)
      return true
    else
      self.errors.add(:checked_out_error, message: "Couldn't checkout cart")
      return false
    end
  end

  protected

  def payment_json(payment_data)
    {
      installment_count: payment_data[:intallment_count],
      funding_instrument: {
        method: 'CREDIT_CARD',
        credit_card: {
          expiration_month: payment_data[:expiration_month],
          expiration_year: payment_data[:expiration_year],
          number: payment_data[:number],
          cvc: payment_data[:cvc],
          holder: {
            fullname: payment_data[:holder][:name],
            birthdate: payment_data[:holder][:birthdate],
            tax_document: {
              type: 'CPF',
              number: payment_data[:holder][:cpf]
            },
            phone: {
              contry_code: payment_data[:holder][:phone_country_code],
              area_code: payment_data[:holder][:phone_area_code],
              number: payment_data[:holder][:phone_number]
            }
          }
        }
      }
    }
  end

  def order_json(installments)
    {
      own_id: generate_order_id,
      amount: {
        subtotals: {
          addition: calculate_additions(installments),
          discount: calculate_discounts
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
        price: cart_item.product.value
      }
    end
  end

  def client_data_to_json
    {
      own_id:    "cliente_musical_mita_#{self.client.id}",
      full_name: self.client.name,
      email:     self.client.email,
      birthdate: self.client.birthdate,
      tax_document: {
        number: self.client.cpf,
        type:   'CPF'
      },
      phone:            self.client.phone.last.phone_to_json,
      shipping_address: self.client.address.last.address_to_json
    }
  end
end
