require 'rake'
require 'factory_girl'
require 'pry'


require_relative '../lib/banking_app'
require_relative 'support/factories'

ActiveRecord::Base.establish_connection(  
  :adapter=> "sqlite3",  
  :host => "localhost",  
  :database=> "banking_example_test.db"
)

Rake.application.init
Rake.application.load_rakefile
Rake.application[:migrate].invoke