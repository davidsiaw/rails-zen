# frozen_string_literal: true

require 'grape-swagger'

# The main API class. Mount your APIs here
class MainApi < Grape::API
  format :json
  prefix :api

  # Version 1
  class V1Api < Grape::API
    version 'v1', using: :path
    mount V1::HealthApi
  end

  mount V1Api
end
