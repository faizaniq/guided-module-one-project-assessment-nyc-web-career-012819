require 'rest-client'
require 'json'
require 'pry'

# def menu_choice
#   prompt = TTY::Prompt.new
#   menu_choice = prompt.select("What would you like to do?", marker: ">") do |menu|
#     menu.choice "Research A Company"
#     menu.choice "Portfolio"
#     menu.choice "Trade"
#   end
# end

def gets_company_info(symbol)
  info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{symbol}/company")
  info_hash = JSON.parse(info_string)
  price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{symbol}/price")
  stock_price = JSON.parse(price_string)
  new_stock = Stock.find_or_create_by(symbol: symbol)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange" ||key == "website" ||key == "description" ||key == "CEO" ||key == "sector"
      new_stock.update_attributes("#{key}": "#{value}")
      puts "#{key} : #{value}"
    end
  end
  # info_hash.each do |key, value|
  #   if key == "symbol" #||key == "companyName" ||key == "exchange" ||key == "website" ||key == "description" ||key == "CEO" ||key == "sector"
  #     new_stock = Stock.find_or_create_by("#{key}": "#{value}")
  #   end
  # end
  puts "Price : #{stock_price}"
  new_stock.update_attributes(price: "#{stock_price}")
  main_menu
end


def gets_active_stocks
  active_string = RestClient.get("https://api.iextrading.com/1.0/stock/market/list/gainers")
  active_hash = JSON.parse(active_string)
#  binding.pry
  active_hash.each do |info|
    info.each do |key, value|
      if key == "symbol" ||key == "companyName" ||key == "open" ||key == "close" ||key == "week52Low" ||key == "week52High"
        puts "#{key} : #{value}"
      end
    end
  end
  main_menu
end

def trader_b(buy)
  info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{buy}/company")
  info_hash = JSON.parse(info_string)
  price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{buy}/price")
  price_hash = JSON.parse(price_string)
  #binding.pry
  current_stock_id = Stock.find_by(symbol: buy)[0]
  buy_stock = Purchase.find_or_create_by(stock_id: current_stock_id)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange"
      puts "#{key} : #{value}"
    end
  end
  puts "Price : #{price_hash}"
  puts "How many would you like to buy?"
  price = price_hash.to_i
  quantity = gets.chomp.to_i
  puts "Order total : #{(price*quantity)}"
  puts "Would you like to place another order?"
  answer = gets.chomp.downcase
  if answer == "yes" ||answer == "y"
    buy_stock.update_attributes(quantity_owned: quantity)
    trade_menu
  elsif answer == "no" ||answer == "n"
    main_menu
  end
end

# def trader_s(sell)
#   info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{sell}/company")
#   info_hash = JSON.parse(info_string)
#   price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{sell}/price")
#   price_hash = JSON.parse(price_string)
#   info_hash.each do |key, value|
#     if key == "symbol" ||key == "companyName" ||key == "exchange"
#       puts "#{key} : #{value}"
#     end
#   end
#   puts "Price : #{price_hash}"
#   puts "How many would you like to sell?"
#   price = price_hash.to_i
#   quantity = gets.chomp.to_i
#   puts "Order total : #{(price*quantity)}"
#   puts "Would you like to place another order?"
#   answer = gets.chomp.downcase
#   if answer == "yes" ||answer == "y"
#     trade_menu
#   elsif answer == "no" ||answer == "n"
#     main_menu
#   end
# end
