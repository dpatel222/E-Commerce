class OrderedItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id id_value order_id product_id quantity updated_at user_id]
  end
end
