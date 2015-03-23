require_relative 'base_interactor'

module BankingApp
  module Interactors
    class GetBalance < BaseInteractor
      
      def call
        begin
          account = BankingApp::Entities::Account.new(get_account_from_repo.attributes)  
          @response[:balance] = account.balance
        rescue ActiveRecord::RecordNotFound
          @response[:errors] = ['Account not found']
        end
        @response
      end

      def get_account_from_repo
        BankingApp::Repositories::AccountRepository.find(@request[:account_id])
      end
    end
  end
end