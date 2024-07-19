class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :users, through: :cart_items
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  has_one_attached :image

  scope :on_sale, -> { where(on_sale: true) }
  scope :recently_updated, -> { where('updated_at >= ?', 0.5.days.ago) }

  def self.ransackable_attributes(auth_object = nil)
    %w[category_id created_at description id id_value name on_sale price stock_quantity
       updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[cart_items category ordered_items orders users]
  end
end
