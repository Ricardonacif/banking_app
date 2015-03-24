require 'spec_helper'

describe BankingApp::Entities::Transfer do

  let(:valid_attributes)    { {source_account_id: 1, destination_account_id: 2, amount: 1000, id: 2} }

  context "valid" do 
    subject(:transfer_entity) {BankingApp::Entities::Transfer.new(valid_attributes)}
    
    it { is_expected.to be_valid }
    it { is_expected.to have_attributes(date: Date.today) }

  end

  context "invalid" do 
    it "should not be valid with negative amount" do 
      invalid_attributes = valid_attributes.update amount: -100
      transfer_entity = BankingApp::Entities::Transfer.new(invalid_attributes)
      expect(transfer_entity).not_to be_valid
    end

    [:id, :source_account_id, :destination_account_id, :amount].each do |attribute|
      it "should not be valid without a #{attribute}" do 
        transfer_entity = BankingApp::Entities::Transfer.new(valid_attributes.update( attribute => nil ))
        expect(transfer_entity).not_to be_valid
      end
    end

  end
  
end
