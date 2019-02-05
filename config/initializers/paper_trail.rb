# frozen_string_literal: true

PaperTrail::Rails::Engine.eager_load!

module PaperTrail
  # Extension to allow papertrail versions to use ULID
  class Version < ActiveRecord::Base
    include ULID::Rails
    ulid :id
    ulid :item_id
  end
end
