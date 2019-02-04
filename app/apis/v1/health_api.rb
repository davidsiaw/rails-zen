# frozen_string_literal: true

module V1
  # Endpoint to check the health of the server
  class HealthApi < Grape::API
    resource :health do
      desc 'Check the health of the server'
      get do
        { result: :ok }
      end
    end
  end
end
