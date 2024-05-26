# frozen_string_literal: true

require 'async/websocket/adapters/rails'

require 'async/redis'
require 'thread/local'

module Chat
  # Websocket control class
  module Redis
    extend Thread::Local

    def self.local
      endpoint = ::IO::Endpoint.tcp('redis', 6379)
      Async::Redis::Client.new(endpoint)
    end
  end
end

# Entrypoint for all websocket connections to this server
class WebsocketController < ApplicationController
  def index; end

  skip_before_action :verify_authenticity_token, only: :connect

  def connect
    channel = params.fetch(:channel, 'chat.general')

    self.response = Async::WebSocket::Adapters::Rails.open(request) do |connection|
      Sync do
        redisclient = Chat::Redis.instance
        subscription_task = Async do
          # Subscribe to the channel and broadcast incoming messages:
          redisclient.subscribe(channel) do |context|
            loop do
              _type, _name, message = context.listen

              # The message is text, but contains JSON.
              connection.send_text(message)
              connection.flush
            end
          end
        end

        # Perpetually read incoming messages and publish them to Redis:
        while (message = connection.read)
          logger.info "Messaged received => #{message.buffer}"
          redisclient.publish(channel, message.buffer)
        end
      rescue Protocol::WebSocket::ClosedError
        logger.info 'Websocket closed'
        # Ignore.
      ensure
        logger.info "Subscription #{subscription_task} stopped"
        subscription_task&.stop
      end
    end
  end
end
