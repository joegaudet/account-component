require_relative './exercise_init'

account_id = Identifier::UUID::Random.get
funds_transfer_id = Identifier::UUID::Random.get
withdrawal_id = Identifier::UUID::Random.get

withdrawn = Messages::Events::Withdrawn.new
withdrawn.withdrawal_id = withdrawal_id
withdrawn.account_id = account_id
withdrawn.amount = 11
withdrawn.time = '2000-01-01T11:11:11.000Z'
withdrawn.processed_time = '2000-01-01T22:22:22.000Z'


account_stream_name = "account-#{account_id}"
funds_transfer_stream_name = "fundsTransfer-#{funds_transfer_id}"

Messaging::Postgres::Write.(withdrawn, account_stream_name, reply_stream_name: funds_transfer_stream_name)


MessageStore::Postgres::Read.(account_stream_name) do |message_data|
  Handlers::Events.(message_data)
end


MessageStore::Postgres::Read.(funds_transfer_stream_name) do |message_data|
  pp message_data
end
