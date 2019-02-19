# frozen_string_literal: true

# The root APIs
# This is where all metadata should be
class RootApi < Grape::API
  format :json

  mount MainApi

  API_INFO = {
    base_path: '/',
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

  add_swagger_documentation API_INFO

  route :any, '*path' do
    status 404
    { error: :not_found }
  end
end
