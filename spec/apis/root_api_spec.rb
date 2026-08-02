# frozen_string_literal: true

RSpec.describe 'RootApi', type: :request do
  it 'returns 404 for unknown paths' do
    get '/unknown/path'
    expect(response).to have_http_status :not_found
    expect(JSON.parse(response.body)).to eq('error' => 'not_found')
  end

  it 'returns 404 for unknown POST paths' do
    post '/unknown/post/path'
    expect(response).to have_http_status :not_found
  end
end
