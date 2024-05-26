# frozen_string_literal: true

RSpec.describe WebsocketController do
  describe 'GET #index' do
    it 'can be gotten' do
      get :index
      expect(response).to have_http_status :ok
    end
  end
end
