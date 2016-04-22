Rails.application.routes.draw do
  get 'oauths/vkontakte'
  post 'toggle_group/:id' => 'groups#toggle_group', as: :toggle_group
  root 'pages#index'

  get 'about' => 'pages#about'
  get 'profile' => 'profile#index', as: :user_profile
  get 'profile/edit', as: :user_profile_edit
  post 'profile/update'
  post 'profile/update_password'


  devise_for :users, :controllers => { :omniauth_callbacks => "oauths" }

  resources :users, :purchases, :comments
  resources :groups do
    get :autocomplete_city_name, on: :collection, as: :cities
  end

end
