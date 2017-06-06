require_relative '../../automated_init'

context "Handle Events" do
  context "Withdrawn" do
    context "Record Withdrawal" do
      handler = Handlers::Events.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      withdrawn = Controls::Events::Withdrawn.example

      withdrawal_id = withdrawn.withdrawal_id or fail
      account_id = withdrawn.account_id or fail
      amount = withdrawn.amount or fail
      effective_time = withdrawn.time or fail

      reply_stream_name = Controls::StreamName::Reply.example

      withdrawn.metadata.reply_stream_name = reply_stream_name

      handler.(withdrawn)

      writer = handler.write

      record_withdrawal = writer.one_reply do |event|
        event.instance_of?(Messages::Replies::RecordWithdrawal)
      end

      test "RecordWithdrawn Reply is Written" do
        refute(record_withdrawal.nil?)
      end

      test "Written to the reply stream stream" do
        written_to_stream = writer.replied?(withdrawn) do |stream_name|
          stream_name == reply_stream_name
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "account_id" do
          assert(withdrawn.account_id == account_id)
        end

        test "amount" do
          assert(withdrawn.amount == amount)
        end

        test "time" do
          assert(withdrawn.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(withdrawn.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end
