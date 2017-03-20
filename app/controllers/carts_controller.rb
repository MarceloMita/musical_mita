class CartsController < ApplicationController
  def show
  end

  def checkout
    payment_data = {
      method: "CREDIT_CARD",
      credit_card: {
        expiration_month: params[:expiration_month],
        expiration_year: params[:expiration_year],
        number: params[:card_number],
        cvc: params[:cvc],
        holder: {
          fullname: params[:name],
          birthdate: params[:birthdate],
          tax_document: {
            type: "CPF",
            number: params[:cpf]
          },
          phone: {
            country_code: params[:phone_country_code],
            area_code: params[:phone_area_code],
            number: params[:phone_number].gsub(/\D/, '')
          }
        }
      }
    }
    customer_data = {
      own_id: "cliente_#{ session[:session_id] }",
      fullname: params[:name],
      email: params[:email]
    }
    @cart.checkout_cart({ customer_data: customer_data, payment_data: payment_data })
  end

  def add_product
    @product = Product.find_using_slug(params[:slug])
    @cart_item = CartItem.find_or_create_by(product_id: @product.id,
                                            cart_id: @cart.id)
    @cart_item.increment!(:quantity)
    respond_to do |format|
      format.js
    end
  end
end
