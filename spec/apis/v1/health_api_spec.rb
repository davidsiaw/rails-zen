# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HealthApi, type: :request do
  it 'returns ok' do
    get '/api/v1/health'
    expect(response.body).to eq({ result: 'ok' }.to_json)
  end

  it 'returns ok status' do
    get '/api/v1/health'
    expect(response).to have_http_status :ok
  end
end
