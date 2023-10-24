require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.has_role? :admin } do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  root 'jobs#index'

  resources :jobs, only: %i[index show]

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :boards do
      member do
        get 'scrape_jobs'
      end
    end
    resources :posts do
      member do
        get 'scrape_jobs'
      end
    end
  end
end
