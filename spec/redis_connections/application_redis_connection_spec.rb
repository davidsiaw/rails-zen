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

  describe '#close' do
    it 'stops and clears the async task' do
      task_double = double('AsyncTask')
      obj = described_class.new('test_channel')
      obj.instance_variable_set(:@async_task, task_double)

      expect(task_double).to receive(:stop)
      obj.close

      expect(obj.instance_variable_get(:@async_task)).to be_nil
    end

    it 'does nothing when async_task is nil' do
      obj = described_class.new('test_channel')
      obj.instance_variable_set(:@async_task, nil)

      expect { obj.close }.not_to raise_error
    end
  end
end
