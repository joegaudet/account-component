require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    context "Reply Stream" do
      withdrawal_id = Controls::ID.example
      account_id = Controls::Account.id
      amount = Controls::Money.example

      reply_stream = 'someReplyStream'

      withdraw = Commands::Withdraw.new

      withdraw.(withdrawal_id: withdrawal_id, account_id: account_id, amount: amount, reply_stream_name: reply_stream)

      write = withdraw.write

      withdraw_message = write.one_message do |written|
        written.instance_of?(Messages::Commands::Withdraw)
      end

      refute(withdraw_message.nil?)

      test "Reply stream is set" do
        assert(withdraw_message.metadata.reply_stream_name == reply_stream)
      end
    end
  end
end
