# frozen_string_literal: true

require 'async/redis'
require 'thread/local'

# Asynchronous Redis Client for pub sub purposes
module AsyncRedisService
  extend Thread::Local

  def self.default
    uri = URI.parse(default_redis_url)
    endpoint = ::IO::Endpoint.tcp(uri.host, uri.port)
    Async::Redis::Client.new(endpoint)
  end

  def self.default_redis_url
    ENV.fetch('REDIS_URL', nil)
  end
end
