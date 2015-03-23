class CreateAccountRepositoryTable < ActiveRecord::Migration
  def change
    create_table :account_repositories, force: true do |t|
      t.decimal :balance
    end
  end
end
