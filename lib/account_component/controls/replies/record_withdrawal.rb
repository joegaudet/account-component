module AccountComponent
  module Controls
    module Replies
      module RecordWithdrawal
        def self.example
          record_withdrawal = AccountComponent::Messages::Replies::RecordWithdrawal.build

          record_withdrawal.withdrawal_id = ID.example
          record_withdrawal.account_id = Account.id
          record_withdrawal.amount = Money.example
          record_withdrawal.time = Controls::Time::Effective.example
          record_withdrawal.processed_time = Controls::Time::Processed.example

          record_withdrawal
        end
      end
    end
  end
end
