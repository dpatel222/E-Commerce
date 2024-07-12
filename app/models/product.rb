class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :users, through: :cart_items
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  scope :on_sale, -> { where(on_sale: true) }
  scope :recently_updated, -> { where('updated_at >= ?', 1.days.ago) }
end
