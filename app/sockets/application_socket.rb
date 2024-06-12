# frozen_string_literal: true

require 'async/websocket/adapters/rails'

# Generic socket system for the application
class ApplicationSocket
  attr_reader :connection

  def open(request)
    Async::WebSocket::Adapters::Rails.open(request) do |connection|
      Sync do
        Rails.logger.debug { "Connection #{connection} opened" }
        @connection = connection
        on_open(connection)

        while (message = connection.read)
          on_message(message)
        end
      rescue Protocol::WebSocket::ClosedError
        Rails.logger.debug { "Connection #{connection} closed" }
        on_closed
      rescue StandardError => e
        Rails.logger.debug { "Connection #{connection} errored" }
        Rails.logger.debug e
        Rails.logger.debug e.backtrace
        on_error(e)
      ensure
        Rails.logger.debug { "Connection #{connection} stopped" }
      end
    end
  end

  def on_message(message); end

  def on_open(connection); end

  def on_closed; end

  def on_error(err); end
end
