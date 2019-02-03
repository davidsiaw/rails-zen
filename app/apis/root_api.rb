# frozen_string_literal: true

require 'grape-swagger'

# The root of the API
class RootApi < Grape::API
  format :json
  add_swagger_documentation base_path: '/api',
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
end
