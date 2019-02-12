class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :company_symbol
      t.string :company_name
      t.string :exchange
      t.string :website
      t.string :ceo
      t.string :sector
      t.string :description
      t.integer :price
    end
  end
end
