Rails.application.routes.draw do
  resources :classrooms do 
    resources :tasks do
      patch 'update_progress', on: :member
    end
  end
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :classroom
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
