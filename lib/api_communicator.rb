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
  price_hash = JSON.parse(price_string)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange" ||key == "website" ||key == "description" ||key == "CEO" ||key == "sector"
      puts "#{key} : #{value}"
    end
  end
  puts "Price : #{price_hash}"
end

def gets_active_stocks
  active_string = RestClient.get("https://api.iextrading.com/1.0/stock/market/list/mostactive")
  active_hash = JSON.parse(active_string)
  active_hash.map do |info|
    info.each do |key, value|
      if info[key] == "symbol" ||info[key] == "companyName" ||info[key] == "primaryExchange" ||info[key] == "week52High" ||info[key] == "week52Low" ||info[key] == "open" ||info[key] == "close"
        binding.pry
        puts "#{info[key]} : #{info[value]}"
      end
    end
  end
end
