# frozen_string_literal: true

<% module_namespacing do -%>
# Description of the <%= class_name %> model
class <%= class_name %> < <%= parent_class_name.classify %>
<%- count = 0 -%>
<% attributes.each do |attribute| -%>
  # @!attribute <%= attribute.name %>
  <%- if attribute.reference? -%>
  #   @return [<%= attribute.name.camelize %>] Description of this attribute
  ulid :<%= attribute.name %>_id
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
  <%- else -%>
  #   @return [<%= attribute.type.to_s.camelize %>] Description of this attribute
  <%- end -%>
<% end -%>
<% attributes.select(&:token?).each do |attribute| -%>
  has_secure_token<% if attribute.name != "token" %> :<%= attribute.name %><% end %>
<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<%- end -%>
end
<% end -%>
