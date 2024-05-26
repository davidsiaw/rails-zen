# frozen_string_literal: true

# class to accept messages from redis channel and send it to the delegate
class BridgeRedisConnection < ApplicationRedisConnection
  def initialize(channel, delegate)
    @delegate = delegate
    super(channel)
  end

  def on_message(msg_type, msg_name, msg_content)
    Rails.logger.debug { "redis message: #{msg_type}, #{msg_name}, #{msg_content}" }
    return unless @delegate.respond_to?(:redis_message)

    Rails.logger.debug 'send redis message'
    @delegate&.redis_message(msg_content)
  end
end
