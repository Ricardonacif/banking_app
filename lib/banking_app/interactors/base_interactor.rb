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
        if @request.params[:id]
          repo = repo_class.find(@request.params[:id])
          repo.update_attributes(@request.object_attributes)
        else
          repo = repo_class.create(@request.object_attributes)
        end
        repo
      end

      def delete(repo_class)
        repo = repo_class.find(@request.params[:id])
        repo.destroy
      end

    end
  end
end