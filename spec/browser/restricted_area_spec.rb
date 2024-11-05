# frozen_string_literal: true

require 'browser_helper'

RSpec.describe 'Restricted Area', :js, type: :browser do
  let(:admin) { create(:admin) }

  it 'sidekiq cannot be accessed without logging in' do
    visit('/sidekiq')
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_link_or_button 'Log in'
    expect(page).to have_content("Sidekiq")
  end

  it 'swagger cannot be accessed without logging in' do
    visit('/swagger')
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_link_or_button 'Log in'
    expect(page).to have_content("Swagger")
  end
end
