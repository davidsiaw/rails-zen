# frozen_string_literal: true

RSpec.describe BridgeRedisConnection do
  before do
    # stub out external stuffs
    async_redis_double = instance_double(Async::Redis::Client)
    allow_any_instance_of(described_class).to receive(:async_redis).and_return(async_redis_double)
    allow(async_redis_double).to receive(:subscribe)

    async_task_double = double('AsyncTask')
    allow_any_instance_of(described_class).to receive(:async_task).and_return(async_task_double)
  end

  it 'calls delegate' do
    thing = double('thing')
    expect(thing).to receive(:redis_message).with('baz')
    obj = described_class.new('awdawd', thing)

    obj.on_message('foo', 'bar', 'baz')
  end

  it 'does not call delegate if delegate doesnt listen' do
    obj = described_class.new('awdawd', 'wrongthing')

    expect(obj.on_message('foo', 'bar', 'baz')).to be_nil
  end

  it 'does not call delegate if nil' do
    obj = described_class.new('awdawd', nil)

    expect(obj.on_message('foo', 'bar', 'baz')).to be_nil
  end
end
