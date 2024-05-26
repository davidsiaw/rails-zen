# frozen_string_literal: true

RSpec.describe ApplicationRedisConnection do
  before do
    # stub out external stuffs
    async_redis_double = instance_double(Async::Redis::Client)
    allow_any_instance_of(described_class).to receive(:async_redis).and_return(async_redis_double)
    allow(async_redis_double).to receive(:subscribe)

    async_task_double = double('AsyncTask')
    allow_any_instance_of(described_class).to receive(:async_task).and_return(async_task_double)
  end

  describe '#publish' do
    it 'calls publish on the async_redis' do
      obj = described_class.new('test_channel_name')

      async_redis_double = instance_double(Async::Redis::Client)
      allow(obj).to receive(:async_redis) { async_redis_double }

      expect(async_redis_double).to receive(:publish).with('test_channel_name', 'foobar')

      obj.publish('foobar')
    end
  end
end
