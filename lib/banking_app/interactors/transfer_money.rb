require_relative 'base_interactor'

module BankingApp
  module Interactors
    class TransferMoney < BaseInteractor
      
      def call
        #validations
        @response[:errors] = []
        transfer = BankingApp::Entities::Transfer.new(request)
        unless transfer.valid?
          @response[:errors] << 'Invalid transfer'
        end
        balance_object = BankingApp::Interactors::GetBalance.new(account_id: transfer.source_account_id).call
        if balance_object[:balance] < transfer.amount
          @response[:errors] << 'No money enough on source account!'
        end
        return @response if @response[:errors].size > 0

        #transfer logic
        source_account = BankingApp::Repositories::AccountRepository.find(request[:source_account_id])
        destination_account = BankingApp::Repositories::AccountRepository.find(request[:destination_account_id])

        BankingApp::Repositories::TransferRepository.transaction do
          @response[:id] = save_repository(BankingApp::Repositories::TransferRepository).id
          source_account.decrement!(:balance, request[:amount])
          destination_account.increment!(:balance, request[:amount])
        end
        @response
      end

    end
  end
end