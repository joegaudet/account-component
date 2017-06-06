require_relative '../../automated_init'

context "Handle Events" do
  context "Withdrawn" do
    context "No Reply Stream" do
      handler = Handlers::Events.new

      withdrawn = Controls::Events::Withdrawn.example
      fail unless withdrawn.metadata.reply_stream_name.nil?

      handler.(withdrawn)

      writer = handler.write

      record_withdrawal = writer.one_reply do |event|
        event.instance_of?(Messages::Replies::RecordWithdrawal)
      end

      test "RecordWithdrawn Reply is Not Written" do
        assert(record_withdrawal.nil?)
      end
    end
  end
end
