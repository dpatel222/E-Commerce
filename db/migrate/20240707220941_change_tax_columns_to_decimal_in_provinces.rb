class ChangeTaxColumnsToDecimalInProvinces < ActiveRecord::Migration[7.1]
  def change
    change_column :provinces, :GST, :decimal, precision: 5, scale: 2, default: 0.0
    change_column :provinces, :PST, :decimal, precision: 5, scale: 2, default: 0.0
    change_column :provinces, :HST, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
