clients = [{
  email: 'marcelo.moip@mailinator.com',
  password: '123moip123',
  password_confirmation: '123moip123',
  cpf: '359.778.898-01',
  name: 'Marcelo Mita',
  birthdate: '29/06/1988'
}]

clients.each do |client|
  cl = Client.find_by(email: client[:email])
  if cl.nil?
    Client.create(client)
  else
    cl.update(client)
  end
end
