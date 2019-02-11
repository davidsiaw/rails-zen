# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount RootApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'
end
