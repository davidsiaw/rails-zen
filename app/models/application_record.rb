# frozen_string_literal: true

# All models inherit this
class ApplicationRecord < ActiveRecord::Base
  include ULID::Rails
  self.abstract_class = true
  ulid :id
end
