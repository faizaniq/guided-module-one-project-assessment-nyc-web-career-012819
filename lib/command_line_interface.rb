def greet
  puts "Welcome to Stock Trader"
end

def enter_name
  puts "Please enter your name"
  gets.chomp.downcase
end

def symbol
  puts "What company would you like to resarch?"
  gets.chomp.downcase
end
