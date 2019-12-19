Rails.application.routes.draw do
  resources :jobs

  root 'jobs#index'

  get 'oauth/callback', 'oauth#callback'
  get 'oauth/authorization', 'oauth#authorization'
end
