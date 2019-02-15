# puts"/$$$$$$  /$$$$$$$$ /$$$$$$   /$$$$$$  /$$   /$$       /$$$$$$$$ /$$$$$$$   /$$$$$$  /$$$$$$$  /$$$$$$$$ /$$$$$$$
#     /$$__  $$|__  $$__//$$__  $$ /$$__  $$| $$  /$$/      |__  $$__/| $$__  $$ /$$__  $$| $$__  $$| $$_____/| $$__  $$
#    | $$  \__/   | $$  | $$  \ $$| $$  \__/| $$ /$$/          | $$   | $$  \ $$| $$  \ $$| $$  \ $$| $$      | $$  \ $$
#    |  $$$$$$    | $$  | $$  | $$| $$      | $$$$$/           | $$   | $$$$$$$/| $$$$$$$$| $$  | $$| $$$$$   | $$$$$$$/
#     \____  $$   | $$  | $$  | $$| $$      | $$  $$           | $$   | $$__  $$| $$__  $$| $$  | $$| $$__/   | $$__  $$
#     /$$  \ $$   | $$  | $$  | $$| $$    $$| $$\  $$          | $$   | $$  \ $$| $$  | $$| $$  | $$| $$      | $$  \ $$
#    |  $$$$$$/   | $$  |  $$$$$$/|  $$$$$$/| $$ \  $$         | $$   | $$  | $$| $$  | $$| $$$$$$$/| $$$$$$$$| $$  | $$
#     \______/    |__/   \______/  \______/ |__/  \__/         |__/   |__/  |__/|__/  |__/|_______/ |________/|__/  |__/"

#
# puts "||====================================================================||
#       ||//$\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\//$\\||
#       ||(100)==================| FEDERAL RESERVE NOTE |================(100)||
#       ||\\$//        ~         '------========--------'                \\$//||
#       ||<< /        /$\              // ____ \\                         \ >>||
#       ||>>|  12    //L\\            // ///..) \\         L38036133B   12 |<<||
#       ||<<|        \\ //           || <||  >\  ||                        |>>||
#       ||>>|         \$/            ||  $$ --/  ||        One Hundred     |<<||
#    ||====================================================================||>||
#    ||//$\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\//$\\||<||
#    ||(100)==================| FEDERAL RESERVE NOTE |================(100)||>||
#    ||\\$//        ~         '------========--------'                \\$//||\||
#    ||<< /        /$\              // ____ \\                         \ >>||)||
#    ||>>|  12    //L\\            // ///..) \\         L38036133B   12 |<<||/||
#    ||<<|        \\ //           || <||  >\  ||                        |>>||=||
#    ||>>|         \$/            ||  $$ --/  ||        One Hundred     |<<||
#    ||<<|      L38036133B        *\\  |\_/  //* series                 |>>||
#    ||>>|  12                     *\\/___\_//*   1989                  |<<||
#    ||<<\      Treasurer     ______/Franklin\________     Secretary 12 />>||
#    ||//$\                 ~|UNITED STATES OF AMERICA|~               /$\\||
#    ||(100)===================  ONE HUNDRED DOLLARS =================(100)||
#    ||\\$//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\$//||
#    ||====================================================================||"



def greet
  puts "Welcome to Stock Trader".rjust(65)
end

def enter_name_and_funds
  puts "Please enter your name"
  name = gets.chomp.downcase
  @new_user = User.find_or_create_by(name: name)
  system 'clear'
  puts "Current Funds : #{@new_user.funds.to_f}"
  puts "Would you like to add funds to your account?"
  answer = gets.chomp.downcase
  if answer == "yes" ||answer == "y"
    system 'clear'
    puts "How much would you like to add?"
    input_funds = gets.chomp
    system 'clear'
    @new_user.update_attributes(funds: (@new_user.funds.to_f + input_funds.to_f))
    main_menu
  elsif answer == "no" ||answer == "n"
    system 'clear'
    main_menu
  end
  system 'clear'
  @new_user
end

def add_funds
  puts "How much would you like to add?"
  input_funds = gets.chomp
  @new_user.update_attributes(funds: (@new_user.funds.to_f + input_funds.to_f))
end

def symbol
  puts "Enter the symbol of the company you would like to research"
  gets.chomp.downcase
end

def buy
  puts "Enter symbol of the stock you like to buy"
  gets.chomp.upcase
end

def sell
  puts "Enter symbol of the stock you like to sell"
  gets.chomp.downcase
end

def gets_portfolio
  binding.pry
  @new_user.purchases.reload
  @new_user.purchases.each do |purchase|
   new_stock_id = purchase.stock_id
   new_symbol = Stock.find_by(id: new_stock_id).symbol
   new_price = Stock.find_by(id: new_stock_id).price.to_f
   qty_owned = purchase.quantity_owned.to_i
    puts "Stock : #{new_symbol}"
    puts "Price : #{new_price}"
    puts "Quantity Owned : #{qty_owned}"
    puts "Total : #{new_price*qty_owned}"
    puts "\n"
  end
  @new_user.purchases.reload
end


###############################################################################
#MENU
def main_menu
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("What would you like to do?", marker: "$") do |menu|
    menu.choice "Research"
    menu.choice "Portfolio"
    menu.choice "Trade"
    menu.choice "New User"
  end
  if menu_choice == "Research"
    system 'clear'
    research_menu
  elsif menu_choice == "Portfolio"
    system 'clear'
    gets_portfolio
    main_menu
  elsif menu_choice == "Trade"
    system 'clear'
    trade_menu
  elsif menu_choice == "New User"
    system 'clear'
    enter_name_and_funds
  end
end

def research_menu
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("How would you like to research?", marker: "$") do |menu|
    menu.choice "Search by Symbol"
    menu.choice "Check Most Active Stocks"
    menu.choice "Main Menu"
  end
  if menu_choice == "Search by Symbol"
    system 'clear'
    gets_company_info(symbol)
  elsif menu_choice == "Check Most Active Stocks"
    system 'clear'
    gets_active_stocks
  elsif menu_choice == "Main Menu"
    system 'clear'
    main_menu
  end
end

def trade_menu
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("Select a trade type", marker: "$") do |menu|
    menu.choice "Buy"
    menu.choice "Sell"
    menu.choice "Main Menu"
  end
  if menu_choice == "Buy"
    system 'clear'
    trader_b(buy)
  elsif menu_choice == "Sell"
    system 'clear'
    trader_s(sell)
  elsif menu_choice == "Main Menu"
    system 'clear'
    main_menu
  end
end

# def portfolio_menu
#   prompt = TTY::Prompt.new
#   menu_choice = prompt.select("Select a trade type", marker: ">") do |menu|
#     menu.choice "Main Menu"
#   end
#   if menu_choice == "Main Menu"
#     main_menu
#   end
# end
