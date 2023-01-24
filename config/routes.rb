require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#index'

  resources :tags, only: %i[ show ]

  resources :search_temperatures
  
  use_doorkeeper

  resource :session, only: %i[ new create destroy ]

  resources :users, except: %i[ index ]

  resource :password_reset, only: %i[new create edit update]
  
  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end

  resources :questions do
    resources :comments, only: %i[ create destroy ]
    resources :answers, exept: %i[ new show ] do 
      member do
        patch "upvote", to: "answers#upvote", format: :js
        patch "downvote", to: "answers#downvote", format: :js
      end
    end
    member do
      patch "upvote", to: "questions#upvote", format: :js
      patch "downvote", to: "questions#downvote", format: :js
    end
  end

  resources :answers, exept: %i[ new show ] do
    resources :comments, only: %i[ create destroy ]
  end

  namespace :admin do
    resources :users, only: %i[ index create edit update destroy ] do
      put 'ban', on: :member
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users do
        get :me, on: :collection
      end
      resources :questions
    end
  end

  controller :qr_codes do
    get :qr_code_generator
    get :qr_code_download
  end
end
