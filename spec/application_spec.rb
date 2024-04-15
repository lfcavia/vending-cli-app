require 'open3'

RSpec.describe 'Vending Machine Interface' do
  let(:application_path) { File.expand_path('../../lib/application.rb', __FILE__) }

  before do
    allow(STDOUT).to receive(:puts)
  end

  def run_application_with_input(*inputs)
    Open3.popen2("ruby #{application_path}") do |stdin, stdout|
      inputs.each do |input|
        stdin.puts input
      end
      stdin.close

      stdout.read
    end
  end

  describe 'Menu' do
    it 'displays the products and prices' do
      output = run_application_with_input('A', 'D')
      expect(output).to include('Green Tea')
      expect(output).to include('3.11€')
    end
  end

  describe 'Shopping' do
    it 'adds products to cart correctly' do
      output = run_application_with_input('B', 'GR1', '2', 'D')
      expect(output).to include('Added 2 x GR1')
    end

    it 'handles invalid product codes' do
      output = run_application_with_input('B', 'INVALID', 'D')
      expect(output).to include('Oops! Invalid product code. Please try again.')
    end

    it 'handles invalid product quantities' do
      output = run_application_with_input('B', 'GR1', 'INVALID', 'D')
      expect(output).to include('Oops! Invalid number. Please try again.')
    end
  end

  describe 'Checkout' do
    it 'calculates and displays the correct total for GR1, GR1' do
      output = run_application_with_input('B', 'GR1', '2', 'C', 'D')
      expect(output).to match(/Total price: 3.11€/)
    end

    it 'calculates and displays the correct total for SR1, SR1, GR1, SR1' do
      output = run_application_with_input('B', 'SR1', '2', 'B', 'GR1', '1', 'B', 'SR1', '1', 'C', 'D')
      expect(output).to match(/Total price: 16.61€/)
    end

    it 'calculates and displays the correct total for GR1, CF1, SR1, CF1, CF1' do
      output = run_application_with_input('B', 'GR1', '1', 'B', 'CF1', '1', 'B', 'SR1', '1', 'B', 'CF1', '2', 'C', 'D')
      expect(output).to match(/Total price: 30.57€/)
    end
  end

  describe 'Exit' do
    it 'exits the loop and says goodbye to the user' do
      output = run_application_with_input('D')
      expect(output).to include('Thanks for shopping! Goodbye!')
    end
  end

  describe 'Invalid input' do
    it 'alerts of invalid input and runs the input trigger again' do
      output = run_application_with_input('INVALID', 'D')
      expect(output).to include('Oops! Invalid input. Please try again.')
    end
  end
end
