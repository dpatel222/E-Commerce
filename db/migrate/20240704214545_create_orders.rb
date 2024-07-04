class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.float :sub_total
      t.float :total
      t.float :GST
      t.float :PST
      t.float :HST

      t.timestamps
    end
  end
end
