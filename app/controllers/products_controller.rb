class ProductsController < ApplicationController
  def marketplace
    @products = Product.all
  end

  def show
  end
end
