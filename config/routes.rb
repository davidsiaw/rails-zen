# frozen_string_literal: true

Rails.application.routes.draw do
  mount RootApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
