require 'spec_helper'

describe BankingApp::Interactors::TransferMoney do

  let(:account_repo_with_balance) { FactoryGirl.create :account_repository, balance: 1500 }
  let(:account_repo_without_balance) { FactoryGirl.create :account_repository, balance: 0 }
  let(:transfered_amount) {BigDecimal.new(1000)}

  def get_balance_from_account account_id
    BankingApp::Interactors::GetBalance.new(account_id: account_id).call
  end

  context "valid money transfer" do
    subject(:transfer_money) {
      BankingApp::Interactors::TransferMoney.new(
        amount: transfered_amount, 
        source_account_id: account_repo_with_balance.id,
        destination_account_id: account_repo_without_balance.id
      ).call
    }

    it "should withdraw money from source account" do
      expect { subject }.to change{ get_balance_from_account(account_repo_with_balance.id)[:balance]}.by(BigDecimal.new(- transfered_amount))
    end

    it "should credit money on destination account" do
      expect { subject }.to change{ get_balance_from_account(account_repo_without_balance.id)[:balance]}.by(BigDecimal.new(transfered_amount))
    end

  end

  context "invalid money transfer" do 
    subject(:invalid_transfer_money) {
      BankingApp::Interactors::TransferMoney.new(
        amount: transfered_amount, 
        source_account_id: account_repo_without_balance.id,
        destination_account_id: account_repo_with_balance.id
      ).call
    }

    it "should return an object with an error" do
      response = subject
      expect(response[:errors].count).to be == 1
    end

    it "should not withdraw money from source account" do
      expect { invalid_transfer_money }.not_to change{ get_balance_from_account(account_repo_with_balance.id)[:balance]}
    end

    it "should not credit money on destination account" do
      expect { invalid_transfer_money }.not_to change{ get_balance_from_account(account_repo_without_balance.id)[:balance]}
    end

  end  
end