class Cart < ApplicationRecord
  belongs_to :client
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  enum status: %w(draft payment paid)

  def calculate_subtotal_value
    value = self.cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.subtotal
    end
  end

  def calculate_discount
    # 5% discount
    if Cupon.find_by(code: self.cupon)
      calculate_subtotal_value * 0.05
    else
      0.0
    end
  end

  def calculate_additions(installments)
    # Addition of 2,5%
    (installments.to_i > 1 ? calculate_total_value * 0.025 : 0)
  end

  def calculate_total_value
    calculate_subtotal_value - calculate_discount
  end

  def calculate_total_price(installments)
    calculate_total_value + calculate_additions(installments)
  end

  def quantity
    self.cart_items.inject(0) { |sum, cart_item| sum + cart_item.quantity }
  end

  def checkout(data)
    begin
      moip_client = MoipClient.new
      order = moip_client.create_order(order_json(data[:installment_count]))
      payment = moip_client.create_payment(order.id, data)

      if self.update(moip_order_id: order.id, moip_payment_id: payment.id, status: 1)
        return true
      else
        self.errors.add(:checked_out_error, message: "Couldn't checkout cart")
        return false
      end
    rescue
      self.errors.add(:checked_out_error, message: "Couldn't checkout cart")
      return false
    end
  end

  protected

  def payment_json(payment_data)
    {
      installment_count: payment_data[:installment_count],
      fundingInstrument: {
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
              contry_code: payment_data[:holder][:country_code],
              area_code: payment_data[:holder][:area_code],
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
        currency: 'BRL',
        subtotals: {
          addition: (calculate_additions(installments) * 100).to_i,
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
