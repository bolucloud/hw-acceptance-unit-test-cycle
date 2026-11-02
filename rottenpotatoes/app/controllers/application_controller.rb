# frozen_string_literal: true

# Base controller for rottenpotatoes application. All other controllers inherit from this controller.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
