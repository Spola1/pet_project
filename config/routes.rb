Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ]

  resources :users, except: %i[ index ] do
    put 'ban', on: :member
  end

  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end

  resources :questions do
    resources :comments, only: %i[ create destroy ]
    resources :answers, exept: %i[ new show ]
  end

  resources :answers, exept: %i[ new show ] do
    resources :comments, only: %i[ create destroy ]
  end

  namespace :admin do
    resources :users, only: %i[ index create edit update destroy ]
  end

  resources :tags, only: %i[ show ]

  root 'pages#index'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end
end
