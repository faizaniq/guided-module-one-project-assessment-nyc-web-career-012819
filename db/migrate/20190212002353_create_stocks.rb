class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :companyName
      t.string :exchange
      t.string :website
      t.string :CEO
      t.string :sector
      t.string :description
      t.integer :price
    end
  end
end
