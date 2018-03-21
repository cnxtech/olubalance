# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(:email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret')

Account.create!(name: 'PNC',   starting_balance: 5000, user_id: 1)
Account.create!(name: 'Chase', starting_balance: 1500, user_id: 1)

Transaction.create!(trx_date: DateTime.now, description: 'DLM',                      amount: -132.72,  account_id: 1)
Transaction.create!(trx_date: DateTime.now, description: 'American Express payment', amount: -100.00,  account_id: 1)
Transaction.create!(trx_date: DateTime.now, description: 'Mortgage',                 amount: -1237.81, account_id: 1)
Transaction.create!(trx_date: DateTime.now, description: 'CL Sale',                  amount:  50.00,   account_id: 1)
Transaction.create!(trx_date: DateTime.now, description: 'Meijer',                   amount: -22.38,   account_id: 1)
Transaction.create!(trx_date: DateTime.now, description: 'Car Payment',              amount: -411.00,  account_id: 1)

Transaction.create!(trx_date: DateTime.now, description: 'Amazon',                   amount: -50.40,   account_id: 2)
Transaction.create!(trx_date: DateTime.now, description: 'Capital One',              amount: -18.83,   account_id: 2)
Transaction.create!(trx_date: DateTime.now, description: 'Whole Foods',              amount: -48.99,   account_id: 2)
Transaction.create!(trx_date: DateTime.now, description: 'Golden Lamb',              amount: -55.16,   account_id: 2)
Transaction.create!(trx_date: DateTime.now, description: 'BP Gas',                   amount: -32.44,   account_id: 2)
Transaction.create!(trx_date: DateTime.now, description: 'Sheetz',                   amount: -37.12,   account_id: 2)
Transaction.create!(trx_date: DateTime.now, description: 'Corner Store',             amount: -10.00,   account_id: 2)