class CreditCard < ApplicationRecord
  has_one :phone, as: :user
  belongs_to :client

  def cc_to_json
    {
      expiration_month: self.expiration_month,
      expiration_year: self.expiration_year,
      number: self.number,
      cvc: self.cvc,
      holder: {
        fullname: self.holder_name,
        birthdate: self.holder_birthdate,
        tax_document: {
          type: 'CPF',
          number: self.holder_cpf
        },
        phone: {
          contry_code: self.phone.country_code,
          area_code: self.phone.area_code,
          number: self.phone.number
        }
      }
    }
  end
end
