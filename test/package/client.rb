require 'account/client'
require 'account/client/controls'

account_id = Identifier::UUID::Random.get
amount = Account::Client::Controls::Money.example

reply_stream_name = Account::Client::Controls::StreamName::Reply.example

Account::Client::Withdraw.(
  account_id: account_id,
  amount: amount,
  reply_stream_name: reply_stream_name
)

stream_name = Messaging::StreamName.stream_name(account_id, 'account')

sleep 1

withdrawal_rejected_data = MessageStore::Postgres::Get::Last.(stream_name)

pp withdrawal_rejected_data
