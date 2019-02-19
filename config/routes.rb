# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :users
  authenticate :user do
    mount GrapeSwaggerRails::Engine => '/swagger'
    mount Sidekiq::Web => '/sidekiq'
  end
  mount RootApi => '/'
end
