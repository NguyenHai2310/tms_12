Rails.application.routes.draw do
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users
  resources :subjects
  resources :tasks
  resources :courses
  resources :enrollment_subjects

  namespace :admin do
    resources :subjects
    resources :users
    resources :enrollment_subjects
    resources :courses
    resources :enrollment_subjects
    resources :courses do 
      resource :enrollments
      get 'assign' => 'enrollments#new'
    end
  end
end