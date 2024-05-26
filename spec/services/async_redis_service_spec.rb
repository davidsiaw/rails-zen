# frozen_string_literal: true

RSpec.describe AsyncRedisService do
  describe '.local' do
    it 'returns a redis client' do
      endpoint_double = double('Endpoint')
      allow(described_class).to receive(:default_redis_url).and_return('redis://something:23123')
      allow(IO::Endpoint).to receive(:tcp).with('something', 23_123) { endpoint_double }
      fakeclient = double('Client')
      allow(Async::Redis::Client).to receive(:new).with(endpoint_double) { fakeclient }

      expect(described_class.default).to eq fakeclient
    end
  end
end
