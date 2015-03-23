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
BankingApp::Repositories::AccountRepository.create(balance: 32)
BankingApp::Repositories::AccountRepository.create(balance: 45)

#calling the use case Get Balance
BankingApp::Interactors::GetBalance.new(account_id: 2).call

