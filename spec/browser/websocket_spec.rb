# frozen_string_literal: true

require 'browser_helper'

RSpec.describe 'Websockets', :js, type: :browser do
  let(:admin) { create(:admin) }

  it 'can send' do
    visit('/websocket')
    fill_in 'chat', with: 'awsaws'
    sleep(1) if ENV['SLEEP']
    find_by_id('chat').native.send_keys(:return)
    sleep(1) if ENV['SLEEP']
    expect(page.body).to match 'awsaws'
    sleep(1) if ENV['SLEEP']
  end

  it 'sends in one tab and receives in another' do
    cur_window = current_window
    visit('/websocket')
    sleep(1) if ENV['SLEEP']

    new_window = open_new_window
    switch_to_window(new_window)
    visit('/websocket')
    sleep(1) if ENV['SLEEP']

    fill_in 'chat', with: 'foo'
    find_by_id('chat').native.send_keys(:return)
    sleep(1) if ENV['SLEEP']

    switch_to_window(cur_window)
    sleep(1) if ENV['SLEEP']
    expect(page.body).to match 'foo'
    fill_in 'chat', with: 'bar'
    find_by_id('chat').native.send_keys(:return)
    sleep(1) if ENV['SLEEP']

    switch_to_window(new_window)
    sleep(1) if ENV['SLEEP']
    expect(page.body).to match 'bar'
    sleep(1) if ENV['SLEEP']
  end
end
