# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Province.create([
#                   { name: 'Alberta', GST: 5.00, PST: 0.00, HST: 0.00 },
#                   { name: 'British Columbia', GST: 5.00, PST: 7.00, HST: 0.00 },
#                   { name: 'Manitoba', GST: 5.00, PST: 7.00, HST: 0.00 },
#                   { name: 'New Brunswick', GST: 0.00, PST: 0.00, HST: 15.00 },
#                   { name: 'Newfoundland and Labrador', GST: 0.00, PST: 0.00, HST: 15.00 },
#                   { name: 'Northwest Territories', GST: 5.00, PST: 0.00, HST: 0.00 },
#                   { name: 'Nova Scotia', GST: 0.00, PST: 0.00, HST: 15.00 },
#                   { name: 'Nunavut', GST: 5.00, PST: 0.00, HST: 0.00 },
#                   { name: 'Ontario', GST: 0.00, PST: 0.00, HST: 13.00 },
#                   { name: 'Prince Edward Island', GST: 0.00, PST: 0.00, HST: 15.00 },
#                   { name: 'Quebec', GST: 5.00, PST: 9.975, HST: 0.00 },
#                   { name: 'Saskatchewan', GST: 5.00, PST: 6.00, HST: 0.00 },
#                   { name: 'Yukon', GST: 5.00, PST: 0.00, HST: 0.00 }
#                 ])

require 'products.csv'
Product.destroy_all

Category.destroy_all

csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

products.each do |product|
  category_name = product['category']
  categories = Category.find_or_create_by(name: category_name)

  Product.create(
    name: product['name'],
    price: product['price'],
    description: product['description'],
    stock_quantity: product['stock quantity'],
    category: categories,
    on_sale: product['on sale']
  )
end
