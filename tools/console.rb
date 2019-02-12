require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end

Stock
company_symbol: "AAPL"
company_name: "Apple"
exchange: "Nasdaq"
website: "www.apple.com"
ceo: "Tim Cook"
sector: "Technology"
description: "Description..."
price: $170
Stock.create(company_symbol: "AAPL", company_name: "Apple", exchange: "Nasdaq", website: "www.apple.com", ceo: "Tim Cook", sector: "Technology", description: "Description...", price: 170)

User
name: "Faizan"
stock_id: 1
quantity_owned: 1

Purchase
stock_id: 1
user_id: 1
price_id: 1
quantity: 1
