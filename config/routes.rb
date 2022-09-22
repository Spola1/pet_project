Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ]

  resources :users, except: %i[ index ]

  resources :questions do
    resources :comments, only: %i[ create destroy ]
    resources :answers, exept: %i[ new show ]
  end

  resources :answers, exept: %i[ new show ] do
    resources :comments, only: %i[ create destroy ]
  end

  namespace :admin do
    resources :users, only: %i[ index create ]
  end

  resources :tags, only: %i[ show ]

  root 'pages#index'
end
