Wmapps::Application.routes.draw do
  resources :users, :except => [:destroy, :edit]
  resources :workers, :only => [:show, :index]
  resources :user_sessions, :only => [:new, :create, :destroy]
  resources :worker_sessions, :only => [:new, :create, :destroy]

  root :to => 'pages#home'

  match '/login',   :to => 'user_sessions#new'
  match '/logout',  :to => 'user_sessions#destroy', via: :delete
  match '/login/workers',   :to => 'worker_sessions#new'
  match '/logout_worker',  :to => 'worker_sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
end
