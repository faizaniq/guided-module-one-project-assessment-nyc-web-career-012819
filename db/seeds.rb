User.destroy_all
Stock.destroy_all
Purchase.destroy_all

faizan = User.find_or_create_by(name: "faizan", funds: 1000000)
joe = User.find_or_create_by(name: "joe", funds: 10000)

apple = Stock.find_or_create_by(company_symbol: "AAPL", company_name: "Apple", exchange: "NASDAQ", website: "www.apple.com", ceo: "Tim Cook", sector: "Technology", description: "Description...", price: 170)
netflix = Stock.find_or_create_by(company_symbol: "NFLX", company_name: "Netflix", exchange: "NASDAQ", website: "www.netflix.com", ceo: "Reed Hashings", sector: "Entertainment", description: "Description...", price: 330)

purchase_faizan = Purchase.find_or_create_by(stock_id: 1, user_id: 1, price: 170, quantity_owned: 100)
purchase_joe = Purchase.find_or_create_by(stock_id: 2, user_id: 2, price: 330, quantity_owned: 50)
