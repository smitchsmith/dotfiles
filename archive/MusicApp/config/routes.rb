Music::Application.routes.draw do
  root 'bands#index'

  resources :users, only: [:new, :create] do
    collection do
      put 'activate/:token', action: 'activate', as: 'activate'
    end
  end
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    member do
      resources :albums, only: [:index, :new, :create]
    end
  end

  resources :albums, except: [:index, :new, :create] do
    member do
      resources :tracks, only: [:index, :new, :create]
    end
  end

  resources :tracks, except: [:index, :new, :create] do
    member do
      resources :notes, only: [:create]
    end
  end

  resources :notes, only: [:destroy]

  get 'all_albums', controller: "albums", as: :all_albums

end