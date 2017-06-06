module AccountComponent
  module Messages
    module Replies
      class RecordWithdrawal
        include Messaging::Message

        attribute :withdrawal_id, String
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        attribute :processed_time, String
      end
    end
  end
end
