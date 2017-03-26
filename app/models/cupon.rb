class Cupon < ApplicationRecord
  def valid_cupon?
    self.expires_at.nil? ||
    self.expires_at < Time.now
  end
end
