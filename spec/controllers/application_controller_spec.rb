# frozen_string_literal: true

RSpec.describe ApplicationController do
  describe '#logger' do
    it 'returns Rails.logger' do
      controller = described_class.new
      expect(controller.logger).to eq(Rails.logger)
    end
  end
end
