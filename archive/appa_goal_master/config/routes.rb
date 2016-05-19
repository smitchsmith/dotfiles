GoalMaster::Application.routes.draw do

  resources :users, only: [:new, :create, :show, :index, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:create, :new, :update] do
      delete :fancy_destroy, on: :collection
  end

  root to: "sessions#new"

end