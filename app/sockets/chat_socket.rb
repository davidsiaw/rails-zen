# frozen_string_literal: true

# websocket handler for chat application
class ChatSocket < ApplicationSocket
  def initialize(channel_name)
    @rc = BridgeRedisConnection.new(channel_name, self)
    super()
  end

  def on_message(message)
    Rails.logger.debug { "message callback: #{message.buffer}" }
    @rc.publish(message.buffer)
  end

  def redis_message(message)
    Rails.logger.debug { "redis receive: #{message}" }
    connection.send_text(message)
    connection.flush
  rescue StandardError => e
    Rails.logger.debug { "error: #{e.message}" }
    @rc.close
  end
end
