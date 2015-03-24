class CreateTransferRepositoryTable < ActiveRecord::Migration
  def change
    create_table :transfer_repositories, force: true do |t|
      t.decimal :amount
      t.datetime :date
      t.integer :source_account_id 
      t.integer :destination_account_id
    end
  end
end