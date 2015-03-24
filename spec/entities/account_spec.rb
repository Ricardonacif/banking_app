require 'spec_helper'

describe BankingApp::Entities::Account do
  
  context "valid" do 
    subject(:account_entity) {BankingApp::Entities::Account.new(id: 10, balance: 240)}

    it { is_expected.to be_valid }
    
  end

  context "invalid" do 
    it "should not be valid without id" do 
      account_entity = BankingApp::Entities::Account.new(balance: 400)
      expect(account_entity).not_to be_valid
    end

    it "should not be valid without a balance" do 
      account_entity = BankingApp::Entities::Account.new(id: 3)
      expect(account_entity).not_to be_valid
    end

  end
  
end
