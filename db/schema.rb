# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_707_223_747) do
  create_table 'cart_items', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'product_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_cart_items_on_product_id'
    t.index ['user_id'], name: 'index_cart_items_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ordered_items', force: :cascade do |t|
    t.integer 'product_id', null: false
    t.integer 'order_id', null: false
    t.integer 'user_id', null: false
    t.integer 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_ordered_items_on_order_id'
    t.index ['product_id'], name: 'index_ordered_items_on_product_id'
    t.index ['user_id'], name: 'index_ordered_items_on_user_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.float 'sub_total'
    t.float 'total'
    t.float 'GST'
    t.float 'PST'
    t.float 'HST'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.integer 'category_id', null: false
    t.string 'description'
    t.float 'price'
    t.integer 'stock_quantity'
    t.boolean 'on_sale'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_products_on_category_id'
  end

  create_table 'provinces', force: :cascade do |t|
    t.string 'name'
    t.decimal 'HST', precision: 5, scale: 2, default: '0.0'
    t.decimal 'PST', precision: 5, scale: 2, default: '0.0'
    t.decimal 'GST', precision: 5, scale: 2, default: '0.0'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password'
    t.integer 'province_id'
    t.string 'address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'cart_items', 'products'
  add_foreign_key 'cart_items', 'users'
  add_foreign_key 'ordered_items', 'orders'
  add_foreign_key 'ordered_items', 'products'
  add_foreign_key 'ordered_items', 'users'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'products', 'categories'
end
