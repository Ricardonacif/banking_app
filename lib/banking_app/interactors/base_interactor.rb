module BankingApp
  module Interactors
    class BaseInteractor
      attr_reader :request, :response

      def initialize(request = {})
        @request = request
        @response = {}
      end

      private

      def save_repository(repo_class)
        if @request[:id]
          repo = repo_class.find(@request[:id])
          repo.update_attributes(@request)
        else
          repo = repo_class.create(@request)
        end
        repo
      end

      def delete(repo_class)
        repo = repo_class.find(@request)
        repo.destroy
      end

    end
  end
end