puts"/$$$$$$  /$$$$$$$$ /$$$$$$   /$$$$$$  /$$   /$$       /$$$$$$$$ /$$$$$$$   /$$$$$$  /$$$$$$$  /$$$$$$$$ /$$$$$$$
    /$$__  $$|__  $$__//$$__  $$ /$$__  $$| $$  /$$/      |__  $$__/| $$__  $$ /$$__  $$| $$__  $$| $$_____/| $$__  $$
   | $$  \__/   | $$  | $$  \ $$| $$  \__/| $$ /$$/          | $$   | $$  \ $$| $$  \ $$| $$  \ $$| $$      | $$  \ $$
   |  $$$$$$    | $$  | $$  | $$| $$      | $$$$$/           | $$   | $$$$$$$/| $$$$$$$$| $$  | $$| $$$$$   | $$$$$$$/
    \____  $$   | $$  | $$  | $$| $$      | $$  $$           | $$   | $$__  $$| $$__  $$| $$  | $$| $$__/   | $$__  $$
    /$$  \ $$   | $$  | $$  | $$| $$    $$| $$\  $$          | $$   | $$  \ $$| $$  | $$| $$  | $$| $$      | $$  \ $$
   |  $$$$$$/   | $$  |  $$$$$$/|  $$$$$$/| $$ \  $$         | $$   | $$  | $$| $$  | $$| $$$$$$$/| $$$$$$$$| $$  | $$
    \______/    |__/   \______/  \______/ |__/  \__/         |__/   |__/  |__/|__/  |__/|_______/ |________/|__/  |__/"


puts "||====================================================================||
      ||//$\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\//$\\||
      ||(100)==================| FEDERAL RESERVE NOTE |================(100)||
      ||\\$//        ~         '------========--------'                \\$//||
      ||<< /        /$\              // ____ \\                         \ >>||
      ||>>|  12    //L\\            // ///..) \\         L38036133B   12 |<<||
      ||<<|        \\ //           || <||  >\  ||                        |>>||
      ||>>|         \$/            ||  $$ --/  ||        One Hundred     |<<||
   ||====================================================================||>||
   ||//$\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\//$\\||<||
   ||(100)==================| FEDERAL RESERVE NOTE |================(100)||>||
   ||\\$//        ~         '------========--------'                \\$//||\||
   ||<< /        /$\              // ____ \\                         \ >>||)||
   ||>>|  12    //L\\            // ///..) \\         L38036133B   12 |<<||/||
   ||<<|        \\ //           || <||  >\  ||                        |>>||=||
   ||>>|         \$/            ||  $$ --/  ||        One Hundred     |<<||
   ||<<|      L38036133B        *\\  |\_/  //* series                 |>>||
   ||>>|  12                     *\\/___\_//*   1989                  |<<||
   ||<<\      Treasurer     ______/Franklin\________     Secretary 12 />>||
   ||//$\                 ~|UNITED STATES OF AMERICA|~               /$\\||
   ||(100)===================  ONE HUNDRED DOLLARS =================(100)||
   ||\\$//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\$//||
   ||====================================================================||"



def greet
  puts "Welcome to Stock Trader"
end

def enter_name
  puts "Please enter your name"
  input_name = gets.chomp.downcase
  puts "Would you like to add funds to your account?"
  answer = gets.chomp.downcase
  if answer == "y"
    puts "How much would you like to add?"
    input_funds = gets.chomp
    User.find_or_create_by(name: input_name, funds: input_funds)
    main_menu
  elsif answer == "n"
    main_menu
  end
end

def symbol
  puts "Enter the symbol of the company you would like to research"
  gets.chomp.downcase
end

def main_menu
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("What would you like to do?", marker: ">") do |menu|
    menu.choice "Research"
    menu.choice "Portfolio"
    menu.choice "Trade"
  end
  if menu_choice == "Research"
    research_menu
  elsif menu_choice == "Portfolio"
    gets_portfolio
  elsif menu_choice == "Trade"
    trade_menu
  end
end

def research_menu
  prompt = TTY::Prompt.new
  menu_choice = prompt.select("How would you like to research?", marker: ">") do |menu|
    menu.choice "Search by Symbol"
    menu.choice "Check Most Active Stocks"
  end
  if menu_choice == "Search by Symbol"
    gets_company_info(symbol)
  elsif menu_choice == "Check Most Active Stocks"
    gets_active_stocks
  end
end
# def menu
#   prompt.select("What would you like to do?", ["Research A Company", "Check My Holdings", "Buy/Sell"])
# end

#
# def research
#   if menu.choice = "Research A Company"
#     puts "What company would you like to research?"
#   end
#   gets.chomp.downcase
# end
