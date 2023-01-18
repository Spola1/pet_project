Rails.application.routes.draw do
  get '/weather' => 'weather#index', :as => 'weather'
  use_doorkeeper
  resource :session, only: %i[ new create destroy ]

  resources :users, except: %i[ index ]
  
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

  resources :tags, only: %i[ show ]

  root 'pages#index'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users do
        get :me, on: :collection
      end
      resources :questions
    end
  end
end
