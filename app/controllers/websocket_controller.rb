# frozen_string_literal: true

# Entrypoint for all websocket connections to this server
class WebsocketController < ApplicationController
  def index; end

  skip_before_action :verify_authenticity_token, only: :connect

  def connect
    channel = params.fetch(:channel, 'chat.general')

    self.response = ChatSocket.new(channel).open(request)
  end
end
