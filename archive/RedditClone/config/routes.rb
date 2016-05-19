RedditClone::Application.routes.draw do

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :subs
  resources :links, except: :index do
    resources :comments, only: [:show, :create]
  end

  post '/comments/:id', to: "comments#reply", as: :comment_reply

  root to: "subs#index"

end