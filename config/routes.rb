# frozen_string_literal: true

Rails.application.routes.draw do
  resources :links
  get '/:hash', to: 'links#redirect'

  root 'pages#index'
end
