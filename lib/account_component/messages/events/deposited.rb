module AccountComponent
  module Messages
    module Events
      class Deposited
        include Messaging::Message

        attribute :deposit_id, String
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        attribute :processed_time, String
        attribute :transaction_position, Integer
      end
    end
  end
end
