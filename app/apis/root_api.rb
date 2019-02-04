# frozen_string_literal: true

require 'grape-swagger'

# The root of the API
class RootApi < Grape::API
  format :json

  API_INFO = {
    base_path: '/api',
    info: {
      title: 'The API Title',
      description: 'A description of the API.',
      contact_name: 'Contact name',
      contact_email: 'Contact@email.com',
      contact_url: 'Contact URL',
      license: 'The name of the license.',
      license_url: 'www.The-URL-of-the-license.org',
      terms_of_service_url: 'termsofservice.com'
    },
    doc_version: '0.0.1',
    hide_documentation_path: true
  }.freeze

  # Version 1
  class V1Api < Grape::API
    version 'v1', using: :path
    mount V1::HealthApi
  end

  mount V1Api

  add_swagger_documentation API_INFO

  desc 'Default route'
  get '/*' do
    status 404
    { error: :not_found }
  end
end
