# frozen_string_literal: true

class SessionsController < ApplicationController

  def new
  end

  def create
    user_info = request.env['omniauth.auth']

    Rails.logger.info "OAUTH"
    Rails.logger.info user_info

    cb_url = "../ui"
    query = { email: user_info[:info][:email] }.to_query
    redirect_to "#{cb_url}?#{query}", allow_other_host: true
  end
end
