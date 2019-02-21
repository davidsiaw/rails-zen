# frozen_string_literal: true

# This is the Admin model. Its required to provide basic access to this website
# You can leave it with just one entry which is the admin if your app uses
# a different authentication provider, or you can use this model to store
# your API admins as well.
class Admin < ApplicationRecord
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         # :registerable, # Disable to prevent sign ins as admin
         :recoverable,
         :rememberable,
         :validatable
end
