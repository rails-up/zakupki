Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'oauths/vkontakte'
  post 'toggle_group/:id' => 'groups#toggle_group', as: :toggle_group
  root 'pages#index'

  get 'about' => 'pages#about'

  resource :profile, only: [:show, :edit, :update], as: :user_profile

  devise_for :users, :controllers => { :omniauth_callbacks => "oauths" }

  resources :users, :purchases, :comments
  resources :groups do
    get :autocomplete_city_name, on: :collection, as: :cities
  end

end
