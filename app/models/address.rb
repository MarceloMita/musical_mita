class Address < ApplicationRecord
  belongs_to :user, polymorphic: true

  def address_to_json
    {
      street:        self.street,
      street_number: self.street_number,
      complement:    self.complement,
      district:      self.district,
      city:          self.city,
      state:         self.state,
      country:       self.country,
      zip_code:      self.zip_code
    }
  end
end
