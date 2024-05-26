# frozen_string_literal: true

# Generic Redis Connection for applications to use
class ApplicationRedisConnection
  def initialize(channel)
    @channel = channel
    async_task
  end

  def on_message(msg_type, msg_name, msg_content); end

  def publish(message)
    async_redis.publish(@channel, message)
  end

  def close
    return if @async_task.nil?

    @async_task&.stop
    @async_task = nil
  end

  private

  def async_task
    @async_task ||= Async do
      async_redis.subscribe(@channel) do |context|
        loop do
          msg_type, msg_name, msg_content = context.listen
          on_message(msg_type, msg_name, msg_content)
        end
      end
    end
  end

  def async_redis
    AsyncRedisService.default
  end
end
