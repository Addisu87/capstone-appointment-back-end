# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# user
User.create(
  id: 123,
  name: 'admin',
  role: 'admin',
  password: 'admin',
  created_at: Time.now,
  updated_at: Time.now
)

# motorcycles
Motorcycle.create(
  model: 'Neiman Marcus Limited Edition Fighter', 
  avatar:'https://cdn.wealthygorilla.com/wp-content/uploads/2019/06/Most-Expensive-Motorbikes-Neiman-Marcus-Limited-Edition-Fighter.webp',
  duration: 48,
  price: 11_000_000,
  description: 'The Neiman Marcus Limited Edition Fighter is an exclusive streetfighter motorcycle by the American Luxury Department Store Brand. It draws its power from an air-cooled V-Twin engine that propels it to a top speed of 300 km/h making it one of the fastest bikes in the world.')

Motorcycle.create(
  model: 'Ecosse ES1 Spirit',
  avatar: 'https://cdn.wealthygorilla.com/wp-content/uploads/2019/06/Most-Expensive-Motorbikes-Ecosse-ES1-Spirit.webp',
  duration: 50,
  price: 7_000_000,
  description: 'The Ecosse Spirit is a limited edition titanium motorcycle and this bike packs enough power to satisfy even the most experienced rider, reaching speeds of 370 kilometres.'
)

# reservations
Reservation.create(
  date: '2022-12-01',
  city: 'Gondar',
  motorcycle_id: 1,
  id: 123
);

Reservation.create(
  date: '2022-12-02',
  city: 'Addis Ababa',
  motorcycle_id: 2,
  id: 123
);

