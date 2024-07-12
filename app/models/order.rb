class Order < ApplicationRecord
  has_many :ordered_items
  belongs_to :user
  has_many :products, through: :ordered_items

  def self.ransackable_attributes(auth_object = nil)
    %w[GST HST PST created_at id id_value sub_total total updated_at user_id]
  end
end
