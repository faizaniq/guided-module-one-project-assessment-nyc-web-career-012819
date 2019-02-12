class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :stock_id
      t.integer :user_id
      t.integer :price
      t.integer :quantity_owned
    end
  end
end
