class CartsController < ApplicationController
  before_action :authenticate_client!, only: [:checkout, :show]
  protect_from_forgery except: [:add_product, :remove_product]
  def show
  end

  def checkout
    current_client.update(checkout_params[:client_data])
    current_client.address.update(checkout_params[:address])
    current_client.phone.update(checkout_params[:phone])
    current_client.credit_card.update(checkout_params[:card])
    current_client.credit_card.phone.update(checkout_params[:holder_phone])
    @cart.update(installment_count: checkout_params[:installment_count])
    if @cart.cart_items.empty?
      flash[:danger] = 'O carrinho está vazio, adicione produtos ao carrinho para realizar a compra.'
      redirect_to :root
    else
      if @cart.checkout
        flash[:success] = 'Pagamento em análise. Acompanhe o status do seu pedido em "Meus Pedidos". Após liberado o pagamento, o pedido será enviado para sua residência.'
        redirect_to :root
      else
        flash[:danger] = 'Não foi possível registrar seu pagamento. Verifique os dados e tente novamente.'
        redirect_to :back
      end
    end
  end

  def add_product
    @product = Product.find_using_slug(params[:slug])
    @cart_item = CartItem.find_or_create_by(product_id: @product.id,
                                            cart_id: @cart.id)
    @cart_item.increment!(:quantity)
    get_cart
    respond_to do |format|
      format.js
    end
  end

  def remove_product
    CartItem.find(params[:id]).destroy
    @cart_item_id = params[:id]
    get_cart
    respond_to do |format|
      format.js
    end
  end

  def apply_cupon
    if Cupon.where(code: params[:cupon_code]).first.try(:valid_cupon?)
      @cart.update(cupon: params[:cupon_code])
    end
    respond_to do |format|
      format.js
    end
  end

  protected

  def checkout_params
    params.permit!
  end
end
