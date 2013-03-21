Wmapps::Application.routes.draw do
  resources :users, :except => [:destroy, :edit]
  resources :user_sessions, :only => [:new, :create, :destroy]

  root :to => 'pages#home'

  match '/login',   :to => 'user_sessions#new'
  match '/logout',  :to => 'user_sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
end
