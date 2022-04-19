# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#  resources :auth do
#    get :login
#    get :callback
#  end

  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
end
