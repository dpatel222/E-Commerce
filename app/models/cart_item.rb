class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id id_value product_id updated_at user_id]
  end
end
