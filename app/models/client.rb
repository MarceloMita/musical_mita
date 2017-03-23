class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :phones, as: :user
  has_many :addresses, as: :user
  has_many :carts

  def current_cart
    self.carts.where(checked_out: false).includes(cart_items: [:product]).first
  end

  def holder_json
    {
      fullname: self.name,
      birthdate: self.birthdate.strftime("%Y-%m-%d"),
      tax_document: {
        type: "CPF",
        number: self.cpf
      },
      phone: self.phones.last.phone_to_json
    }
  end
end
