require_relative 'base_entity'
module BankingApp
  module Entities
    class Transfer < BaseEntity
      attr_accessor :id, :amount, :source_account_id, :destination_account_id, :date
      validates_presence_of :id, :amount, :source_account_id, :destination_account_id

      validates :amount, numericality: { greater_than: 0 }

      def initialize(attributes = {})
        super attributes
        @date = Date.today
      end

    end
  end
end