require_relative 'base_entity'

module BankingApp
  module Entities
    class Account < BaseEntity
      attr_accessor :id, :balance
      validates_presence_of :id, :balance
    end
  end
end