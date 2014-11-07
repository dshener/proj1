Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
  resources :trainers
  #resources :pokemons

  patch 'pokemon/:id', to:'pokemon#capture', as:'capture'
  delete 'pokemon/:id',to:'pokemon#damage', as:'damage'
  post 'create', to: 'pokemon#create', as: 'pokecreate'
  get 'new', to: 'pokemon#new', as: 'new'
end
