class User < ApplicationRecord
  belongs_to :province
  has_many :cart_items
  has_many :products, through: :cart_items
  has_many :orders
  has_many :ordered_items
end
