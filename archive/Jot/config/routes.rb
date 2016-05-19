Jot::Application.routes.draw do

  resources :users, except: [:index, :destroy, :edit] do
    member do
      resources :favorites, only: :index, as: "user_favorites"
    end
  end

  root to: "pages#random"

  get "jots", to: "statics#index"

  get "/users/password_reset/:token", to: "password_resets#edit", as: "password_reset"
  put "/users/password_reset/:token", to: "password_resets#update", as: "password_reset"
  post "/users/:id/new_password_reset", to: "password_resets#create", as: "password_resets"

  get "/users/:id/change_password", to: "password_changes#new", as: "user_change_password"
  post "/users/:id/change_password", to: "password_changes#create", as: "user_change_password"

  resource :current_user, only: :show

  resource :session, only: [:new, :create, :destroy]

  resources :syntaxes, only: :index

  resources :versions, only: [:create, :update]
  get "versions/closest", to: "versions#closest", as: "closest"

  resources :comments, only: [:create, :destroy]

  resources :favorites, only: [:create, :destroy]

  resources :binaries, only: [:create, :destroy]

  get ":url_fragment", to: "pages#edit", as: "page"
  put ":url_fragment", to: "pages#update", as: "page"
  post ":url_fragment", to: "pages#create", as: "page"

  get ":url_fragment/change_password", to: "password_changes#new", as: "page_change_password"
  post ":url_fragment/change_password", to: "password_changes#create", as: "page_change_password"

  # post ":url_fragment/comments", to: "comments#create", as: "comments"
  # post ":url_fragment/versions", to: "versions#create", as: "versions"

  get ":url_fragment/session", to: "page_sessions#new", as: "page_session"
  post ":url_fragment/session", to: "page_sessions#create", as: "page_session"

  # post ":url_fragment/favorite", to: "favorites#create", as: "favorite"
  # delete ":url_fragment/favorite", to: "favorites#destroy", as: "favorite"

  get ":url_fragment/shares", to: "shares#index", as: "shares"
  post ":url_fragment/shares", to: "shares#create", as: "shares"
  resources :shares, only: :destroy

  # post ":url_fragment/binaries", to: "binaries#create", as: "binaries"

  # resource ":url_fragment", as: "pages", controller: "pages", only: [:create, :show, :update] do
  #   collection do
  #     resources :comments, only: :create
  #     resources :versions, only: :create
  #   end
  # end

end
