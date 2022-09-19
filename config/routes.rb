Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ]
  resources :users, except: %i[ index ]
  resources :questions do
    resources :answers
  end

  namespace :admin do
    resources :users, only: %i[ index create ]
  end

  root 'pages#index'
end
