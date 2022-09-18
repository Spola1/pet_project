Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ]
  resources :users, except: %i[ index ]
  resources :questions do
    resources :answers
  end

  root 'pages#index'
end
