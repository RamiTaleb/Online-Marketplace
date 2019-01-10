# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
iphone = Product.find_or_create_by(title: 'iphone', price: 999.99, inventory_count: 100)
sweater = Product.find_or_create_by(title: 'sweater', price: 99.99, inventory_count: 50)
apple = Product.find_or_create_by(title: 'apple', price: 0.99, inventory_count: 1000)
orange = Product.find_or_create_by(title: 'orange', price: 0.49, inventory_count: 0)
soccer_ball = Product.find_or_create_by(title: 'soccer ball', price: 54.99, inventory_count: 10)
