cupons = [
  {
    code: 'EXPIRED123',
    expires_at: Time.now
  },
  {
    code: 'NEVER_EXPIRES',
    expires_at: nil
  }
]

cupons.each do |cupon|
  Cupon.find_or_create_by(code: cupon[:code]).update(cupon)
end
