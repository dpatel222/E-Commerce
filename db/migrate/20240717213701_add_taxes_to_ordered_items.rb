class AddTaxesToOrderedItems < ActiveRecord::Migration[7.1]
  def change
    add_column :ordered_items, :hst, :decimal
    add_column :ordered_items, :pst, :decimal
    add_column :ordered_items, :gst, :decimal
  end
end
