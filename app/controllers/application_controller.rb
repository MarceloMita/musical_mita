class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_cart

  def get_cart
    # Unsecure, but fast way of use session. Next step would be create a authentication system
    @cart = Cart.includes(:cart_items).find_or_create_by(session_id: session[:session_id])
  end
end
