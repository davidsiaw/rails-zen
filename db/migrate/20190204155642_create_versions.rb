# frozen_string_literal: true

class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions, id: :uuid do |t|
      t.string   :item_type, null: false
      t.uuid     :item_id,   null: false
      t.string   :event,     null: false
      t.string   :whodunnit
      t.jsonb    :object
      t.jsonb    :object_changes

      t.datetime :created_at
    end
    add_index :versions, %i[item_type item_id]
  end
end
