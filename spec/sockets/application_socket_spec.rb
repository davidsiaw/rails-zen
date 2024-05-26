# frozen_string_literal: true

RSpec.describe ApplicationSocket do
  it 'uses the async websocket' do
    allow(Async::WebSocket::Adapters::Rails).to receive(:open).with('request')
    described_class.new.open('request')
    expect(Async::WebSocket::Adapters::Rails).to have_received(:open).with('request')
  end
end
