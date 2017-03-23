class Phone < ApplicationRecord
  belongs_to :user, polymorphic: true

  def phone_to_json
    {
      country_code: self.country_code,
      area_code:    self.area_code,
      number:       self.number
    }
  end
end
