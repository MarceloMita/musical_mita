class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_cart

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthdate, :cpf])
  end

  def get_cart
    # Unsecure, but fastest way of use session.
    # Next step would be create a authentication system

    if current_client
      @cart = current_client.current_cart
      @cart.update(session_id: session[:session_id])
    else
      @cart = Cart.includes(cart_items: [:product]).
                find_or_create_by(session_id: session[:session_id],
                                  checked_out: false)
    end
  end
end
