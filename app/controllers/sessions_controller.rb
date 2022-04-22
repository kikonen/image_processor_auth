# frozen_string_literal: true

class SessionsController < ApplicationController

  def new
  end

  def create
    user_info = request.env['omniauth.auth']

    Rails.logger.info "OAUTH"
    Rails.logger.info user_info


    api = ApiRequest.new
    system_token = Token.create_system_token
    email = user_info[:info][:email]
    response = api.get(
      url: "/users/query/by_email",
      query: { email: email },
      token: system_token)
    user = response.content if response.success?

    unless user
      response = api.post(
        url: "/users",
        token: system_token,
        body: {
          email: email
        })
      user = response.content if response.success?
    end

    unless user
      redirect_to login_path
      return
    end

    Rails.logger.info user

    # TODO KI hardcoded path; get from "cb"
    cb_url = "/ui/logged_in"
    query = { id: user[:id] }.to_query
    redirect_to "#{cb_url}?#{query}", allow_other_host: true
  end
end
