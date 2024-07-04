class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :users, through: :cart_items
  has_many :ordered_items
  has_many :orders, through: :ordered_items
end
