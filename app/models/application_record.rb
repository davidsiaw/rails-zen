# frozen_string_literal: true

# All models inherit this
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
