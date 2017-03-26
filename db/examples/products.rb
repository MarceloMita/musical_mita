products = [
  {
    title: 'Violão Canário',
    description: "Violão clássico de alta qualidade, com acabamento em carvalho.",
    image_name: 'violao-classico.jpg',
    value: 687.99
  },
  {
    title: 'Banjo Grande',
    description: "Banjo grande acústico, com acabamento metálico.",
    image_name: 'banjo-grande.jpg',
    value: 399.40
  },
  {
    title: 'Ukulele Tenor',
    description: "Ukulele tenor acabamento em carvalho.",
    image_name: 'ukulele-tenor.jpg',
    value: 537.89
  },
  {
    title: 'Guitarra Eagle',
    description: "Guitarra eagle com acabamento em madeira.",
    image_name: 'guitarra.jpg',
    value: 1982.75
  },
  {
    title: 'Carron Elétrico',
    description: "Carron Elétrico com dupla captação e assento estofado.",
    image_name: 'carron-eletrico.jpg',
    value: 789.35
  },
  {
    title: 'Oboé Clássico',
    description: "Oboé clássico preto",
    image_name: 'oboe.jpg',
    value: 1279.99
  },
  {
    title: 'Saxofone Tenor',
    description: "Saxofone Tenor Dourado",
    image_name: 'saxofone-tenor.jpg',
    value: 1899.98
  },
  {
    title: 'Violino',
    description: "Violino Clássico alto",
    image_name: 'violino.jpg',
    value: 1345.77
  }
]

products.each do |product|
  Product.find_or_create_by(product)
end
