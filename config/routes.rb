Rails.application.routes.draw do
  resources :todo_lists
  resource :session, only: %i[ new create destroy ]

  resources :users, except: %i[ index ]

  resources :todo_lists

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
end
