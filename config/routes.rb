require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.has_role? :admin } do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  root 'jobs#index'

  resources :jobs, only: %i[index show] do
    collection do
      get 'search_location'
    end
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :boards do
      member do
        get 'scrape_jobs'
      end
    end
    resources :posts do
      collection do
        patch :update_status
      end
      member do
        get 'scrape_jobs'
      end
    end
    resources :job_analytics, only: [:index] do
      post 'scrape_jobs', on: :collection
      get 'download', on: :collection
    end
  end
end
