# puts"/$$$$$$  /$$$$$$$$ /$$$$$$   /$$$$$$  /$$   /$$       /$$$$$$$$ /$$$$$$$   /$$$$$$  /$$$$$$$  /$$$$$$$$ /$$$$$$$
#     /$$__  $$|__  $$__//$$__  $$ /$$__  $$| $$  /$$/      |__  $$__/| $$__  $$ /$$__  $$| $$__  $$| $$_____/| $$__  $$
#    | $$  \__/   | $$  | $$  \ $$| $$  \__/| $$ /$$/          | $$   | $$  \ $$| $$  \ $$| $$  \ $$| $$      | $$  \ $$
#    |  $$$$$$    | $$  | $$  | $$| $$      | $$$$$/           | $$   | $$$$$$$/| $$$$$$$$| $$  | $$| $$$$$   | $$$$$$$/
#     \____  $$   | $$  | $$  | $$| $$      | $$  $$           | $$   | $$__  $$| $$__  $$| $$  | $$| $$__/   | $$__  $$
#     /$$  \ $$   | $$  | $$  | $$| $$    $$| $$\  $$          | $$   | $$  \ $$| $$  | $$| $$  | $$| $$      | $$  \ $$
#    |  $$$$$$/   | $$  |  $$$$$$/|  $$$$$$/| $$ \  $$         | $$   | $$  | $$| $$  | $$| $$$$$$$/| $$$$$$$$| $$  | $$
#     \______/    |__/   \______/  \______/ |__/  \__/         |__/   |__/  |__/|__/  |__/|_______/ |________/|__/  |__/"
#
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

new_user = ''

def greet
  puts "Welcome to Stock Trader"
end

def enter_name_and_funds
  puts "Please enter your name"
  name = gets.chomp.downcase
  new_user = User.find_or_create_by(name: name)
  puts "Would you like to add funds to your account?"
  answer = gets.chomp.downcase
  if answer == "yes" ||answer == "y"
    puts "How much would you like to add?"
    input_funds = gets.chomp
      # binding.pry
    new_user.update_attributes(funds: (new_user.funds.to_i + input_funds.to_i))
    main_menu(new_user)
  elsif answer == "no" ||answer == "n"
    main_menu(new_user)
  end
end

def add_funds(new_user)
  puts "How much would you like to add?"
  input_funds = gets.chomp
    # binding
  new_user.update_attributes(funds: (new_user.funds.to_i + input_funds.to_i))
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
  Purchase.find_each do |purchase|
    if  Purchase.user_id == new_user.id
      puts "#{new_user.name}"
    end
  end
end


###############################################################################
#MENU
def main_menu(new_user)
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("What would you like to do?", marker: ">") do |menu|
    menu.choice "Research"
    menu.choice "Portfolio"
    menu.choice "Trade"
    menu.choice "New User"
  end
  if menu_choice == "Research"
    research_menu
  elsif menu_choice == "Portfolio"
    gets_portfolio
  elsif menu_choice == "Trade"
    trade_menu(new_user)
  elsif menu_choice == "New User"
    enter_name_and_funds
  end
end

def research_menu
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("How would you like to research?", marker: ">") do |menu|
    menu.choice "Search by Symbol"
    menu.choice "Check Most Active Stocks"
    menu.choice "Main Menu"
  end
  if menu_choice == "Search by Symbol"
    gets_company_info(symbol)
  elsif menu_choice == "Check Most Active Stocks"
    gets_active_stocks
  elsif menu_choice == "Main Menu"
    main_menu
  end
end

def trade_menu(new_user)
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("Select a trade type", marker: ">") do |menu|
    menu.choice "Buy"
    menu.choice "Sell"
    menu.choice "Main Menu"
  end
  if menu_choice == "Buy"
    trader_b(buy, new_user)
  elsif menu_choice == "Sell"
    trader_s(sell)
  elsif menu_choice == "Main Menu"
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
