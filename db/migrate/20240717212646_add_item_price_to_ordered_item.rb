class AddItemPriceToOrderedItem < ActiveRecord::Migration[7.1]
  def change
    add_column :ordered_items, :item_price, :float
  end
end
