# frozen_string_literal: true

class EnableExtensions < ActiveRecord::Migration[5.2]
  def change
    enable_extension('pgcrypto')
    enable_extension('citext')
  end
end
