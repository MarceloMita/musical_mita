# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '#########################################'
puts '##          Creating Products          ##'
puts '#########################################'

load Rails.root.join('db/examples/products.rb')

puts '#########################################'
puts '##          Creating Cupons            ##'
puts '#########################################'

load Rails.root.join('db/examples/cupons.rb')

puts '#########################################'
puts '##          Creating Clients           ##'
puts '#########################################'

load Rails.root.join('db/examples/clients.rb')
