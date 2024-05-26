# frozen_string_literal: true

RSpec.describe ChatSocket do
  describe '#on_message' do
    it 'publishes' do
      fakeconn = instance_double(BridgeRedisConnection)
      allow(BridgeRedisConnection).to receive(:new) { fakeconn }
      obj = described_class.new('foobar')

      allow(fakeconn).to receive(:publish)
      obj.on_message(double('buffer', buffer: 'baz'))
      expect(fakeconn).to have_received(:publish).with('baz')
    end
  end

  describe '#redis_message' do
    it 'sends the thing to the connection' do
      fakeconn = instance_double(BridgeRedisConnection)
      allow(BridgeRedisConnection).to receive(:new) { fakeconn }
      obj = described_class.new('foobar')

      wsconn = double('WebsocketConnection')
      allow(obj).to receive(:connection) { wsconn }

      allow(wsconn).to receive(:send_text)
      allow(wsconn).to receive(:flush)

      obj.redis_message('blabla')

      expect(wsconn).to have_received(:send_text).with('blabla')
      expect(wsconn).to have_received(:flush)
    end

    it 'closes the redis connection if the connection errors' do
      fakeconn = instance_double(BridgeRedisConnection)
      allow(BridgeRedisConnection).to receive(:new) { fakeconn }
      obj = described_class.new('foobar')

      double('WebsocketConnection')
      allow(obj).to receive(:connection) { raise 'meow' }

      allow(fakeconn).to receive(:close)
      obj.redis_message('testmessage')
      expect(fakeconn).to have_received(:close)
    end
  end
end
