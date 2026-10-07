# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaperTrail::Version do
  include ActiveSupport::Testing::TimeHelpers

  describe '#created_at' do
    # PaperTrail does not stamp created_at on destroy, and ulid-rails disables
    # Rails' own create timestamp, so the value must come from the version's ULID.
    it 'falls back to the version id, not the item id, when the column is NULL' do
      admin = travel_to(Time.zone.local(2026, 1, 1, 12)) { create(:admin) }
      travel_to(Time.zone.local(2026, 1, 2, 12)) { admin.destroy! }

      version = described_class.find_by!(event: 'destroy')

      expect(version.created_at).to be_within(1.second).of(Time.zone.local(2026, 1, 2, 12))
    end
  end
end
