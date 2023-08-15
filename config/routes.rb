# frozen_string_literal: true

Rails.application.routes.draw do
  resources :links
  root 'pages#index'
end
