# frozen_string_literal: true

# This is the User model. Its required to provide basic access to this website
# You can leave it with just one entry which is the admin if your app uses
# a different authentication provider, or you can use this model to store
# your API users if you want your API to manage users.
class User < ApplicationRecord
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
