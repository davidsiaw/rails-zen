# frozen_string_literal: true

require 'grape-swagger'

class RootApi < Grape::API
  format :json
  add_swagger_documentation base_path: '/api',
                            title: 'asdasd API',
                            doc_version: '0.0.1',
                            hide_documentation_path: true,
                            #endpoint_auth_wrapper: WineBouncer::OAuth2, # This is the middleware for securing the Swagger UI
                            #swagger_endpoint_guard: 'oauth2 false',     # this is the guard method and scope
                            token_owner: 'resource_owner'               # This is the method returning the owner of the token
end
