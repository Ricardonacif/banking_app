require 'rake'
require 'active_record'
require 'pry'

require_relative 'lib/banking_app'

ActiveRecord::Base.establish_connection(  
  :adapter=> "sqlite3",  
  :host => "localhost",  
  :database=> "banking_example.db"
)

Rake.application.init
Rake.application.load_rakefile
Rake.application[:migrate].invoke

#populating accounts
account_with_money = BankingApp::Repositories::AccountRepository.create(balance: 10000)
poor_account = BankingApp::Repositories::AccountRepository.create(balance: 0)

#calling the use case Get Balance
BankingApp::Interactors::GetBalance.new(account_id: account_with_money.id).call

#calling the use case Transfer Money
BankingApp::Interactors::TransferMoney.new(
  amount: 240, 
  source_account_id: account_with_money.id,
  destination_account_id: poor_account.id
).call

#checking money on poor_account now
puts BankingApp::Interactors::GetBalance.new(account_id: poor_account.id).call[:balance]
puts BankingApp::Interactors::GetBalance.new(account_id: account_with_money.id).call[:balance]