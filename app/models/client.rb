class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :phone, as: :user
  has_one :address, as: :user
  has_many :carts

  after_create :generate_complements

  def current_cart
    cart = self.carts.where(status: 0).includes(cart_items: [:product]).first
    if cart.nil?
      cart = Cart.create(client_id: self.id)
    end
    return cart
  end

  protected

  def generate_complements
    Address.create(user: self, country: 'Brasil')
    Phone.create(user: self, country_code: '55')
  end

end
