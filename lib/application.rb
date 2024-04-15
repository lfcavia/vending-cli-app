require_relative 'product'
require_relative 'checkout'
require_relative 'rule'

class Application
  def initialize
    @products = {
      'GR1' => Product.new('GR1', 'Green Tea', 3.11),
      'SR1' => Product.new('SR1', 'Strawberries', 5.00),
      'CF1' => Product.new('CF1', 'Coffee', 11.23)
    }
    @checkout = Checkout.new(Rule.new)
    @cart = []
  end

  def start
    puts "\n Welcome to the Good-Snacks online vending!"
    loop do
      display_options
      action = gets.chomp.strip.upcase
      break if action == 'D'
      handle_action(action)
    end
    puts 'Thanks for shopping! Goodbye!'
  end

  private

  def display_options
    puts "\n ** Please enter letter to choose action. ** "
    puts "\n A - See menu | B - Shop | C - Checkout | D - Exit "
  end

  def handle_action(action)
    case action
    when 'A'
      display_menu
    when 'B'
      shop
    when 'C'
      checkout
    else
      puts 'Oops! Invalid input. Please try again.'
    end
  end

  def display_menu
    puts "\n| Code | Name          | Price  |"
    puts '|------|---------------|--------|'
    @products.each_value do |product|
      puts "| #{product.code.ljust(5)}| #{product.name.ljust(14)}| #{format('%.2f€', product.price).ljust(7)}|"
    end
    puts "\n** Special Discounts **"
    puts ' - Green Tea: buy-one-get-one-free'
    puts ' - Strawberries: 4.50€/each if you get 3 or more'
    puts ' - Coffee: 7.49€/each if you get 3 or more'
  end

  def shop
    puts "\n What would you like? Please enter the code."
    code_input = gets.chomp.strip.upcase
    if @products.key?(code_input)
      puts "\n How many?"
      n = gets.chomp.strip.to_i
      if n > 0
        input = [code_input] * n
        puts "\n Added #{n} x #{code_input}."
        @cart.concat(input)
      else
        puts 'Oops! Invalid number. Please try again.'
      end
    else
      puts 'Oops! Invalid product code. Please try again.'
    end
  end

  def checkout
    puts "\n| Checkout Summary#{''.ljust(4)}|"
    puts "|#{'-' * 21}|"
    count = Hash.new(0)
    @cart.each { |code| count[code] += 1 }
    count.each do |code, qty|
      puts "| #{qty} x #{code.ljust(16)}|"
    end
    puts "|#{'-' * 21}|"
    @cart.each do |code|
      @checkout.scan(@products[code]) if @products[code]
    end
    puts "| Total price: #{format('%.2f€', @checkout.total)} |"
    @cart.clear  # Clear cart after checkout
  end
end

app = Application.new
app.start
