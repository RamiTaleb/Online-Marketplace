# These will be the products we will be working with.
# You are free to remove/add any products you'd like.

Product.find_or_create_by(title: 'iphone', price: 999.99, inventory_count: 100)
Product.find_or_create_by(title: 'sweater', price: 99.99, inventory_count: 50)
Product.find_or_create_by(title: 'apple', price: 0.99, inventory_count: 1000)
Product.find_or_create_by(title: 'orange', price: 0.49, inventory_count: 0)
Product.find_or_create_by(title: 'soccer ball', price: 54.99, inventory_count: 10)
