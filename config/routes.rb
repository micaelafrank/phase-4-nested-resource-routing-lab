Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create] do
    #nested resource for items:
    resources :items, only: [:index, :show, :create]
  end

  resources :items, only: [:index, :show]
end
