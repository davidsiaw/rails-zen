# frozen_string_literal: true

module PaperTrail
  # Extension to allow papertrail versions to use ULID
  class Version < ActiveRecord::Base
    include PaperTrail::VersionConcern
    include ULID::Rails
    ulid :id
    ulid :item_id
  end
end
