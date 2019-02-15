require 'rest-client'
require 'json'
require 'pry'

def gets_company_info(symbol)
  system 'clear'
  info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{symbol}/company")
  info_hash = JSON.parse(info_string)
  price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{symbol}/price")
  stock_price = JSON.parse(price_string)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange" ||key == "website" ||key == "description" ||key == "CEO" ||key == "sector"
      puts "#{key} : #{value}"
    end
  end
  puts "Price : #{stock_price}"
  main_menu
end


def gets_active_stocks
  system 'clear'
  active_string = RestClient.get("https://api.iextrading.com/1.0/stock/market/list/mostactive")
  active_hash = JSON.parse(active_string)
  active_hash.each do |info|
    info.each do |key, value|
      if key == "symbol" ||key == "companyName" ||key == "open" ||key == "close" ||key == "week52Low" ||key == "week52High"
        puts "#{key} : #{value}"
      end
      #puts "\n"
    end
  end
  main_menu
end

def trader_b(buy)
  system 'clear'
  info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{buy}/company")
  info_hash = JSON.parse(info_string)
  price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{buy}/price")
  price_hash = JSON.parse(price_string)
  new_stock = Stock.find_or_create_by(symbol: buy)
  new_stock.update_attributes(price: price_hash)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange" ||key == "website" ||key == "description" ||key == "CEO" ||key == "sector"
       new_stock.update_attributes("#{key}": "#{value}")
    end
  end
  current_stock_id = Stock.find_by(symbol: buy).id
  #  binding.pry
  current_stock_price = Stock.find_by(symbol: buy).price
  buy_purchase = Purchase.find_or_create_by(stock_id: current_stock_id, price: current_stock_price, user_id: @new_user.id)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange"
      puts "#{key} : #{value}"
    end
  end
  puts "Price : #{price_hash}"
  puts "Current Funds Balance : #{@new_user.funds.to_f}"
  puts "How many would you like to buy?"
  quantity = gets.chomp.to_i
  price = price_hash.to_f
  total_order = price*quantity
  funds_change = (@new_user.funds.to_f - total_order.to_f)
  if funds_change <= 0
    puts "Insufficient funds, please add funds to your account"
    puts "Order total : #{total_order}"
    puts "Current Funds Balance : #{@new_user.funds.to_f}"
    add_funds
    trade_menu
  else
    @new_user.update_attributes(funds: funds_change)
    buy_purchase.update_attributes(quantity_owned: (buy_purchase.quantity_owned.to_i + quantity))
    puts "Order total : #{total_order}"
    puts "Updated Funds Balance : #{funds_change}"
  end
  puts "Would you like to place another order?"
  answer = gets.chomp.downcase
  if answer == "yes" ||answer == "y"
    system 'clear'
    trade_menu
  elsif answer == "no" ||answer == "n"
    system 'clear'
    main_menu
  end
end

def trader_s(sell)
  system 'clear'
  info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{sell}/company")
  info_hash = JSON.parse(info_string)
  price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{sell}/price")
  price_hash = JSON.parse(price_string)
  sell_stock = Stock.find_by(symbol: sell.upcase)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange"
      puts "#{key} : #{value}"
    end
  end
  puts "Price : #{price_hash}"
  puts "Quantity Owned : #{@new_user.purchases[0].quantity_owned}"
  puts "How many would you like to sell?"
  price = price_hash.to_f
  quantity = gets.chomp.to_i
  total_order = price*quantity
  funds_balance = @new_user.update_attributes(funds: (@new_user.funds.to_f + total_order.to_f))
  sell_purchase = Purchase.find_by(stock_id: sell_stock.id, user_id: @new_user.id)
  if (sell_purchase.quantity_owned - quantity) <= 0
    sell_purchase.destroy
  else
    sell_purchase.update_attributes(quantity_owned: sell_purchase.quantity_owned - quantity)
  end
  puts "New Funds Balance : #{@new_user.funds.to_f}"
  puts "Would you like to place another order?"
  answer = gets.chomp.downcase
  if answer == "yes" ||answer == "y"
    system 'clear'
    trade_menu
  elsif answer == "no" ||answer == "n"
    system 'clear'
    main_menu
  end
end
