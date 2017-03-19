class ProductsController < ApplicationController
  def marketplace
    @products = Product.all
  end

  def show
  end

  def add_product_to_cart
    @product = Product.find_using_slug(params[:slug])
    @cart_item = CartItem.find_or_create_by(product_id: @product.id,
                                            cart_id: @cart.id)
    @cart_item.increment!(:quantity)
    respond_to do |format|
      format.js
    end
  end
end
