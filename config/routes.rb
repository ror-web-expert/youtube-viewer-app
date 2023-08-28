require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  root 'home#index'

  resources :home, only: [:index]

  namespace :admin do
    resources :dashboard, only: [:index]
  end
end
