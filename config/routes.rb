# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  get 'websocket', to: 'websocket#index'
  match 'connect', to: 'websocket#connect', via: %i[get connect]

  authenticate :admin do
    mount GrapeSwaggerRails::Engine => '/swagger'
    mount Sidekiq::Web => '/sidekiq'
  end
  mount RootApi => '/'
end
