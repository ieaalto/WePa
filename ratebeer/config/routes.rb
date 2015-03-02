Ratebeer::Application.routes.draw do

  resources :styles

  resources :memberships

  resources :beer_clubs

  resources :users

  get 'signup', to: 'users#new'

  get 'signin', to: 'sessions#new'

  get 'places', to: 'places#index'

  get 'places/:id', to: 'places#show'

  post 'places', to:'places#search'

  delete 'signout', to: 'sessions#destroy'

  delete "session", to: 'sessions#destroy'

  resources :beers

  resources :breweries

  resources :ratings, only:[:index, :new, :create, :destroy]

  resource :session, only: [:new, :create, :delete]

  root 'breweries#index'

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'suspend', on: :member
  end

  resources :memberships do
    post 'confirm',on: :member
  end

  get 'beerlist', to:'beers#list'

  get 'brewerylist', to: 'breweries#list'

end