require 'spec_helper'

describe BankingApp::Interactors::GetBalance do
  
  context "existing account" do 

    let(:repo) { FactoryGirl.create :account_repository }

    it "should return an object with a value" do
      response = BankingApp::Interactors::GetBalance.new(account_id: repo.id).call
      expect(response[:balance]).to be_present
    end

  end

  context "non existing account" do 

    it "should return an object with an error" do
      response = BankingApp::Interactors::GetBalance.new(account_id: 999).call
      expect(response[:errors].count).to be == 1
    end

  end  

  
end
