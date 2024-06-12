# frozen_string_literal: true

# Every controller should inherit this
class ApplicationController < ActionController::Base
  def logger
    Rails.logger
  end
end
