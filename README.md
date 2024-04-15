# Vending Machine CLI Application

This Ruby-based application simulates a vending machine interface where users can view a menu of products, add them to their cart, and see the total price with applied discounts at checkout.

* Developed in Ruby version 3.1.2p20
* TDD with Rspec and Open3 Ruby gems
* Designed to be run in command line 

## Motivation

MVP for teams to brainstorm around Amenitiz's new product: "24h Snacks".

The goal is to offer our hoteliers a 24h digital vending machine service, they can controll from our all-in-one platform, and offer to their guests through the hotel app.

Let's relief their pain managing room service or controlling the mini-bar. Save them time, money and headackes!

## Features

- **View Products**: Users can view a list of available products along with their prices and special discounts.
- **Shopping**: Users can add products to their cart by entering product codes and quantities, and get a confirmation message right after.
- **Checkout**: The application calculates the total cost of items in the cart, applying special discount rules when applicable.
- **Exit**: Users can exit the application at any time.

## Project Structure

In order to keep it as simple as possible, while achieving a scalable Model-View-Controller structure, the application consists of the following files:

- **application.rb**: The main entry point for the application. It handles user interactions and manages the flow of the application.
- **product.rb**: Defines the `Product` class. Each product has a code, name, and price.
- **checkout.rb**: Contains the `Checkout` class which manages the shopping cart and applies discounts during checkout, according to the total aggregated quantity per product.
- **rule.rb**: Defines the `Rule` class which contains the logic for discount rules based on product codes.

### Assumptions

- User will only enter one product code at a time
- Each product will have a unique code
- Discount rules are named by their description for scalability purposes

### Available Products & Discounts

This application supports the following products and discount rules:

**Products**

| Code | Name          | Price  |
|------|---------------|--------|
| GR1  | Green Tea     | 3.11€  |
| SR1  | Strawberries  | 5.00€  |
| CF1  | Coffee        | 11.23€ |

**Discount rules**

- **Buy-one-get-one-free (Applied to GR1)**: for every unit you buy you get another one for free.
- **Minus 50 cents (Applied to SR1)**: Price drops 50 cents per unit if you buy three or more.
- **Drops to 2/3 (Applied to CF1)**: Price drops 2/3 per unit if you buy three or more.

## Testing

A Rspec test has been developed to test each file well-functioning independently.

Note the application_spec.rb file mocks user interaction with the Open3 gem, replicating input and output with its module Popen2.

## Potential scalability

This simple application could be further developed creating a Ruby on Rails application following a similar Model-View-Controller stucture, using PostgreSQL to persist data and control sotck and developing the frontend.

For this, the current `Product`, `Rule` and `Checkout` classes could be developed with a Model-Controller, and the user interface from the `Application` class would be transformed into the View.

- **Add more products**: in the correspondent data file.
- **Add new discounts**: new types of discounts could be easily as new methods in the Rule Model.
- **Add or change products to a discount rule**: by changing the product code in the discount rule.
- **Add new features**: to be discussed how UX could be improven with more complex functionalities such as editing the basket, or showing the subtotal price for each add-to-cart action.

## Installation

To run this application, you need to have Ruby installed on your machine. You can download and install Ruby from [https://www.ruby-lang.org](https://www.ruby-lang.org).

### Running Instructions

1. Clone the repository to your local machine:
git clone <repository_url>

2. Navigate to the application directory:
cd path_to_application

3. Run the application:
ruby application.rb
