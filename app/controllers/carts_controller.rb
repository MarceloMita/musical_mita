class CartsController < ApplicationController
  before_action :authenticate_client!, only: [:checkout, :show]
  def show
  end

  def checkout
    @cart.checkout(params)
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
