require 'rest-client'
require 'json'
require 'pry'

def gets_company_info(symbol)
  info_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{symbol}/company")
  info_hash = JSON.parse(info_string)
  price_string = RestClient.get("https://api.iextrading.com/1.0/stock/#{symbol}/price")
  price_hash = JSON.parse(price_string)
  info_hash.each do |key, value|
    if key == "symbol" ||key == "companyName" ||key == "exchange" ||key == "website" ||key == "description" ||key == "ceo" ||key == "sector"
      puts "#{key} : #{value}"
    end
  end
  puts "Price : #{price_hash}"
end
