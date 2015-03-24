require 'active_model'

module BankingApp
  module Entities
    class BaseEntity
      include ActiveModel::Validations

      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end

    end
  end
end