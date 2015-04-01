Rails.application.routes.draw do
  root 'welcome#index'

  get 'terms', to: 'terms#index'
  get 'about', to: 'about#index'
  get 'faq', to: 'common_questions#index'



  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new'
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout

  resources :users


  resources :projects do
    resources :tasks
    resources :memberships, only: [:index, :create, :update, :destroy]
  end


  resources :tasks, only: [] do
    resources :comments, only: [:create]
  end

  resources :tracker_projects, only: [:show]
end
