class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.float :HST
      t.float :PST
      t.float :GST

      t.timestamps
    end
  end
end
