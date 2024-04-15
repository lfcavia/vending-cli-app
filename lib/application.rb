require_relative 'product'
require_relative 'checkout'
require_relative 'rule'

# Seeding the available products in stock
products = {
  'GR1' => Product.new('GR1', 'Green Tea', 3.11),
  'SR1' => Product.new('SR1', 'Strawberries', 5.00),
  'CF1' => Product.new('CF1', 'Coffee', 11.23)
}

# Checkout is initialize with an instance of Rule, so it has access to the
# different Rule methods defining the special pricing applied at checkout price calculation
checkout = Checkout.new(Rule.new)

# Printing interface that gets user input
puts "\n Welcome to the A-vending machine!"
action = nil
cart = []
until action == 'D'
  puts "\n ** Please enter letter to choose action. ** "
  puts "\n A - See menu | B - Shop | C - Checkout | D - Exit "

  action = gets.chomp.strip.upcase
  case action
  # Menu
  when 'A'
    puts "\n| Code | Name          | Price  |"
    puts '|------|---------------|--------|'
    products.each_value do |product|
      puts "| #{product.code.ljust(5)}| #{product.name.ljust(14)}| #{format('%.2f€', product.price).ljust(7)}|"
    end
    puts "\n** Special Discounts **"
    puts ' - Green Tea: buy-one-get-one-free'
    puts ' - Strawberries: 4.50€/each if you get 3 or more'
    puts ' - Coffee: 7.49€/each if you get 3 or more'

  # Shop
  when 'B'
    # ADD PREVENTION FOR FAKE CODES
    puts "\n What would you like? Please enter the code."
    code_input = gets.chomp.strip.upcase

    if products.key?(code_input)
      puts "\n How many?"
      n = gets.chomp.strip.to_i
      if n.integer? && n != 0
        input = [code_input] * n
        puts "\n Added #{n} x #{code_input}."
        cart.concat(input)
      else
        puts 'Oops! Invalid number. Please try again.'
      end
    else
      puts 'Oops! Invalid product code. Please try again.'
    end

  # Checkout
  when 'C'
    puts "\n| Checkout Summary#{''.ljust(3)}|"
    puts "|#{'-' * 20}|"
    count = Hash.new(0)
    cart.each { |code| count[code] += 1 }
    count.each do |code, qty|
      puts "| #{qty} x #{code.ljust(15)}|"
    end
    puts "|#{'-' * 20}|"
    cart.each do |code|
      checkout.scan(products[code]) if products[code]
    end
    puts "| Total price: #{format('%.2f€', checkout.total)} |"
  else
    action == 'D' ? '' : (puts 'Oops! Invalid input. Please try again.')
  end
end
puts 'Thanks for shopping! Goodbye 👋'
