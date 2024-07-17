class AddTotalPriceToOrderedItem < ActiveRecord::Migration[7.1]
  def change
    add_column :ordered_items, :total_price, :float
  end
end
