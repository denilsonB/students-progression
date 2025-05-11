Rails.application.routes.draw do
  get 'pages/about'
  resources :classrooms do
    get :classroom_students 
    resources :students, only: [:create]
    resources :tasks do
      patch 'update_progress', on: :member
      patch 'update_time_spent', on: :member
      resources :feedbacks, only: [:index, :create]
      get :students_progress
    end
  end
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :classroom
  get '/sobre', to: 'pages#about', as: :about
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
