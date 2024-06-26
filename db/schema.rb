# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_190_219_160_906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'citext'
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'admins', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at', precision: nil
    t.datetime 'remember_created_at', precision: nil
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at', precision: nil
    t.datetime 'last_sign_in_at', precision: nil
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at', precision: nil
    t.datetime 'confirmation_sent_at', precision: nil
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at', precision: nil
    t.datetime 'updated_at', precision: nil
    t.index ['confirmation_token'], name: 'index_admins_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_admins_on_unlock_token', unique: true
  end

  create_table 'versions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'item_type', null: false
    t.uuid 'item_id', null: false
    t.string 'event', null: false
    t.string 'whodunnit'
    t.jsonb 'object'
    t.jsonb 'object_changes'
    t.datetime 'created_at', precision: nil
    t.index %w[item_type item_id], name: 'index_versions_on_item_type_and_item_id'
  end
end
