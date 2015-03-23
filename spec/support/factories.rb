FactoryGirl.define do
  factory :account_repository, class: BankingApp::Repositories::AccountRepository do
    balance 445
  end
end
